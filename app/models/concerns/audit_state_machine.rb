# frozen_string_literal: true

module AuditStateMachine
  extend ActiveSupport::Concern

  # The state in the event model is an enum as follows:
  # enum state: { planning: 0,
  #               planned: 1,
  #               in_progress: 2,
  #               pending_approval: 3,
  #               completed: 4,
  #               closed: 5 }

  included do
    # rubocop:disable Style/HashSyntax

    #  estimated_start_at:  set by the organizer at desc, required fieldable
    #  estimated_closed_at: set by the organizer at desc, required fieldable
    #  real_start_at: not, used, will be ignored
    #  real_started_at: set by SM when audit passes to `in_progress`
    #    ("in progress"), when owner clicks on "realise audit".
    #  completed_at:  set by the SM when the audit passes to `completed`,
    #    when the organizer validates the audit.
    #  real_closed_at:  set by the SM when the audit passes to `closed`,
    #    when all the events linked to the audit are closed,
    #    the audit is "auto-closed".
    #  created_at: Rails default on record creation
    #  updated_at: Rails default on record update

    # organizer creates an audit
    state_machine :state, initial: :planning do
      ## AFTER TRANSITION HOOKS

      after_transition to: :in_progress do |audit|
        audit.update(real_started_at: Date.today)
      end

      after_transition to: :completed do |audit|
        audit.update(completed_at: Date.today)
        audit.events.each(&:create_please)
        audit.audit_elements.each do |ae|
          ae.events.each(&:create_please)
        end
      end

      after_transition to: :closed do |audit|
        audit.update(real_closed_at: Date.today)
      end

      ## TRANSITIONS
      # owner
      event :finish_planning do
        transition :planning => :planned,
                   if: lambda { |a|
                         a.required_desc_fields? &&
                           a.required_plan_fields?
                       }
      end

      # owner
      event :start_processing do
        transition :planned => :in_progress,
                   if: lambda { |a|
                     a.required_desc_fields? &&
                       a.required_plan_fields?
                   }
      end

      # owner
      event :finish_audit do
        transition :in_progress => :pending_approval,
                   if: lambda { |a|
                         a.required_desc_fields? &&
                           a.required_plan_fields? &&
                           a.required_declared_events_fields? &&
                           a.required_synthesis_fields?
                       }
      end

      # organizer
      event :approve_report do
        transition :pending_approval => :completed
      end

      # organizer
      event :refuse_report do
        transition :pending_approval => :in_progress
      end

      # automatic when all events all closed
      event :auto_close do
        transition :completed => :closed, if: :events_closed?
      end

      # organizer, owner, admin
      event :force_close do
        requires_comment

        transition :completed => :closed
      end

      # organizer, owner, admin
      event :back_in_progress do
        requires_comment

        transition :completed => :in_progress
        transition %i[pending_approval completed] => :in_progress
      end
    end
    # rubocop:enable Style/HashSyntax
  end

  def events_closed?
    events_from_elements = audit_elements.map(&:events).flatten
    all_events = events_from_elements + events
    all_events.empty? || all_events.map(&:state).uniq == ["closed"]
  end
end
