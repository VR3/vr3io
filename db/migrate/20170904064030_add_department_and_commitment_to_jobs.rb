class AddDepartmentAndCommitmentToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :department, :string
    add_column :jobs, :commitment, :string
  end
end
