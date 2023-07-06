# frozen_string_literal: true

module UserImport
  extend ActiveSupport::Concern

  included do
    enum csv_headers: {
      email: 0,
      lastname: 1,
      firstname: 2,
      process_profile_type: 3,
      improver_profile_type: 4,
      gender: 5,
      language: 6,
      phone: 7,
      mobile_phone: 8,
      function: 9,
      service: 10,
      working_date: 11
    }

    # TODO: Refactor self.import_form_csv into smaller methods (user_limit error add, CSV line parse, etc.)
    # TODO: Rename `self.import_form_csv` to `self.import_from_csv`
    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
    def self.import_form_csv(file, customer)
      #
      # Hash with the following keys :
      # - global
      # - data
      #

      ## checking UTF-8 encoding
      if (content = file.read).encoding != Encoding::UTF_8
        content = content.force_encoding(Encoding::ISO_8859_1.name).encode(Encoding::UTF_8.name)
      end

      errors = { global: [], data: [] }
      created_users = []

      begin
        parsed_csv = CSV.parse(content, col_sep: ";", headers: true, encoding: Encoding::UTF_8.name)
      rescue CSV::MalformedCSVError => e
        logger.error "failed to parse csv #{e}"
        logger.error e.backtrace
        errors[:global] << { e.class.to_s => e.message }
        return { errors: errors, users: created_users }
      end

      User.transaction do
        power_user = 0
        simple_user = 0

        available_pu = customer.available_power_users
        available_u = customer.available_simple_users

        begin
          if parsed_csv.empty?
            errors[:global] << { csv_empty: I18n.t("controllers.settings.handle_user_import.csv_empty") }
          else
            parsed_csv.each_with_index do |row, line|
              begin
                new_user = customer.users.create(row.to_hash.compact, &:randomize_password)
              rescue StandardError => e
                logger.error "Error while importing csv #{e}"
                logger.error e.backtrace
                errors[:data] << { (line + 2).to_s => e.message.to_s }
                next
              end

              new_user.power_user? ? power_user += 1 : simple_user += 1

              errors[:data] << { (line + 2).to_s => new_user.errors.messages } if new_user.errors.any?

              new_user.invite! do |u|
                u.skip_invitation = true
              end

              created_users << new_user
            end
          end
        rescue StandardError => e
          logger.error "Error while importing csv #{e}"
          logger.error e.backtrace
          errors[:global] << { e.class.to_s => e.message }
        end

        if customer.is_user_limit_reached?(power_user, simple_user, available_pu, available_u)
          errors[:global]
          if (available_pu - power_user).negative?
            errors[:global] << {
              user_number_limit: I18n.t(
                "activerecord.errors.models.customer.max_user_limit.need_more_pu",
                number: power_user - available_pu
              )
            }
          end

          if (available_u - simple_user).negative?
            errors[:global] << {
              user_number_limit: I18n.t(
                "activerecord.errors.models.customer.max_user_limit.need_more_u",
                number: simple_user - available_u
              )
            }
          end
        end

        raise ActiveRecord::Rollback if errors.map { |_k, v| v unless v.blank? }.compact.any?
      end

      { errors: errors, users: created_users }
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity

    def self.generate_csv_template
      CSV.generate(headers: true, col_sep: ";", encoding: Encoding::UTF_8.name) do |csv|
        csv << User.csv_headers.keys.to_a
      end
    end
  end
end
