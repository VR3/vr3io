class AddAttachmentVideoToProjects < ActiveRecord::Migration
    include Paperclip::Schema
    def self.up
    change_table :projects do |t|
      t.attachment :video
    end
  end

  def self.down
    remove_attachment :projects, :video
  end
end
