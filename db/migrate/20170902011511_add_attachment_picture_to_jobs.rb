class AddAttachmentPictureToJobs < ActiveRecord::Migration
  def self.up
    change_table :jobs do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :jobs, :picture
  end
end
