class Project < ApplicationRecord
    include Paperclip::Glue

    extend FriendlyId
	friendly_id :slug_candidates, :use => [:slugged, :finders]

    has_attached_file :image, :styles => { standard: "562x387>", thumb: "281x194>" }, :default_url => "https://s3-us-west-2.amazonaws.com/vr3io/projectmissing.png", :storage => :s3, :s3_region => ENV['AWS_REGION'], :bucket => ENV['S3_BUCKET_NAME'], :access_key_id => ENV['AWS_ACCESS_KEY_ID'], :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'], :url => "https://s3-us-west-2.amazonaws.com/vr3io/projects/:client/:attachment/:style/:filename"

    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

    has_attached_file :video, :styles => { :medium => { :geometry => "640x480", :format => 'mp4' }, :thumb => { :geometry => "160x120", :format => 'jpeg', :time => 10 } }, :processors => [:transcoder], :default_url => "https://s3-us-west-2.amazonaws.com/vr3io/projectmissing.png", :storage => :s3, :s3_region => ENV['AWS_REGION'], :bucket => ENV['S3_BUCKET_NAME'], :access_key_id => ENV['AWS_ACCESS_KEY_ID'], :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'], :url => "https://s3-us-west-2.amazonaws.com/vr3io/projects/:client/:attachment/:style/:filename"
    
    validates_attachment_content_type :video, content_type: /\Avideo\/.*\Z/

    Paperclip.interpolates :client do |a,s|
       a.instance.client.downcase
    end

	def slug_candidates
		[:title, [:title, :client], [:title, :client, :provider]]
    end
    
end
