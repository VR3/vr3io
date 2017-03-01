class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.string :position
      t.integer :type
      t.string :location
      t.string :salary
      t.text :overview
      t.text :qualifications
      t.text :responsabilities

      t.timestamps
    end
  end
end
