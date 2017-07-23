class AddAttachmentLogoToArticles < ActiveRecord::Migration
  include Paperclip::Schema
  def self.up
    change_table :articles do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :articles, :logo
  end
end
