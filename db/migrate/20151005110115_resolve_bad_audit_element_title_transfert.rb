class ResolveBadAuditElementTitleTransfert < ActiveRecord::Migration[4.2]
  def change
    reversible do |dir|
      dir.up do
        AuditElement.where(:audit_element_subject_id => nil).each do |audit_element|
          subject = audit_element.is_process? ? audit_element.process.title : audit_element.old_title
          audit_element_subject = audit_element.audit.audit_element_subjects.find_by(:subject => subject)
          if audit_element_subject.nil?
            audit_element_subject = AuditElementSubject.create!(:subject => subject, :audit => audit_element.audit)
          end
          audit_element.audit_element_subject = audit_element_subject
          audit_element.save(:validate => false)
        end
      end
      dir.down do
        # Unreversible
      end
    end
  end
end
