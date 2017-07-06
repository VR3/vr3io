class Project < ApplicationRecord
	
	extend FriendlyId
	friendly_id :slug_candidates, :use => [:slugged, :finders]

	has_attached_file :project_image, styles: { standard: "562x387>", thumb: "281x194>" }, default_url: "http://static.vr3.io/vr3/img/main/projectmissing.png"
  validates_attachment_content_type :project_image, content_type: /\Aimage\/.*\z/

	has_attached_file :project_video, :styles => {
    :medium => { :geometry => "640x480", :format => 'mp4' },
    :thumb => { :geometry => "160x120", :format => 'jpeg', :time => 10 }
  }, :processors => [:transcoder]
	validates_attachment_content_type :video, content_type: /\Avideo\/.*\Z/

	def slug_candidates
		[
			:title,
			[:title, :client],
			[:title, :client, :provider],
		]
		
	end

end
