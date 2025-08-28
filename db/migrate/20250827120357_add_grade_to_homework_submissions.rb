class AddGradeToHomeworkSubmissions < ActiveRecord::Migration[6.1]
  def change
    add_column :homework_submissions, :grade, :integer
  end
end
