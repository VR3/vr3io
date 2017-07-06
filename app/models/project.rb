class Project < ApplicationRecord
	
	extend FriendlyId
	friendly_id :slug_candidates, :use => [:slugged, :finders]

	has_attached_file :project_image, styles: { standard: "562x387>", thumb: "281x194>" }, default_url: "http://static.vr3.io/vr3/img/main/projectmissing.png"
  validates_attachment_content_type :project_image, content_type: /\Aimage\/.*\z/

	has_attached_file :project_video, :styles => {
    :medium => { :geometry => "640x480", :format => 'flv' },
    :thumb => { :geometry => "100x100#", :format => 'jpg', :time => 10 }
  }, :processors => [:transcoder]

	def slug_candidates
		[
			:title,
			[:title, :client],
			[:title, :client, :provider],
		]
		
	end

end
