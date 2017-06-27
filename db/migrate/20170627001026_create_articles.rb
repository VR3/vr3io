class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :author
      t.string :source
      t.string :body
      t.string :link
      t.string :image_url

      t.timestamps
    end
  end
end
