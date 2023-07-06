class UpdateFieldValuesToAssessmentScaleRating < ActiveRecord::Migration[5.2]
  def up
    if Rake::Task.task_defined?("data_migration:risk_module:risk_to_assessment_scale_rating")
      Rake::Task["data_migration:risk_module:risk_to_assessment_scale_rating"].invoke
    else
      puts "RiskScaleRating ain't no more"
    end
  end

  def down
    puts "Assessing the unassessable"
  end
end
