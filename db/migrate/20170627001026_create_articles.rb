class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :source
      t.string :body
      t.string :link

      t.timestamps
    end
  end
end
