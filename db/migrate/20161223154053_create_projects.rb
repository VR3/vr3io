class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.string :link
      t.string :client
   	  t.string  :provider
    	t.datetime :date

      t.timestamps
    end
  end
end
