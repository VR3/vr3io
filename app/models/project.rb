class Project < ApplicationRecord
        
    extend FriendlyId
	friendly_id :slug_candidates, :use => [:slugged, :finders]

	#has_attached_file :image, styles: { standard: "562x387>", thumb: "281x194>" }, default_url: "http://static.vr3.io/vr3/img/main/projectmissing.png"
    #validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

    has_attached_file :image, :styles => { standard: "562x387>", thumb: "281x194>" }, :default_url => "http://s3-us-west-2.amazonaws.com/vr3io/projectmissing.png", :storage => :s3, :url => "https://s3-us-west-2.amazonaws.com/vr3iodev/projects/:client/:attachment/:style/:filename"

    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

    has_attached_file :video, :styles => { :medium => { :geometry => "640x480", :format => 'mp4' }, :thumb => { :geometry => "160x120", :format => 'jpeg', :time => 10 } }, :processors => [:transcoder], :default_url => "https://static.vr3.io/vr3/img/main/projectmissing.png", :storage => :s3, :url => "https://s3-us-west-2.amazonaws.com/vr3iodev/projects/:client/:attachment/:style/:filename"
    
    validates_attachment_content_type :video, content_type: /\Avideo\/.*\Z/

    Paperclip.interpolates :client do |a,s|
       a.instance.client.downcase
    end

	def slug_candidates
		[:title, [:title, :client], [:title, :client, :provider]]
    end

    private

    
end
