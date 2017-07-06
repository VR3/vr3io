class AddAttachmentProjectVideoToProjects < ActiveRecord::Migration
  def self.up
    change_table :projects do |t|
      t.attachment :project_video
    end
  end

  def self.down
    remove_attachment :projects, :project_video
  end
end
