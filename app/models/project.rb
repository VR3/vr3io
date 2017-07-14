class Project < ApplicationRecord
    
    require 'paperclip'
    include Paperclip
    
    extend FriendlyId
	friendly_id :slug_candidates, :use => [:slugged, :finders]

	#has_attached_file :image, styles: { standard: "562x387>", thumb: "281x194>" }, default_url: "http://static.vr3.io/vr3/img/main/projectmissing.png"
    #validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

    has_attached_file :image, 
        :styles => { standard: "562x387>", thumb: "281x194>" }, :default_url => "http://static.vr3.io/vr3/img/main/projectmissing.png", :storage => :ftp, :path => "/public_html/static/vr3/img/projects/:client/:attachment/:style/:filename", :url => "http://static.vr3.io/vr3/img/projects/:client/:attachment/:style/:filename", :ftp_servers => [
            {
                :host => "ftp.vr3.io",
                :user => "admin@vr3.io",
                :password => "Admin123!--"
            }
        ], :ftp_connect_timeout => 5, :ftp_ignore_failing_connections => true, :ftp_keep_empty_directories => true
    

    has_attached_file :video, :styles => { :medium => { :geometry => "640x480", :format => 'mp4' }, :thumb => { :geometry => "160x120", :format => 'jpeg', :time => 10 } }, :processors => [:transcoder], :default_url => "http://static.vr3.io/vr3/img/main/projectmissing.png", :storage => :ftp, :path => "/public_html/static/vr3/img/projects/:client/:attachment/:style/:filename", :url => "http://static.vr3.io/vr3/img/projects/:client/:attachment/:style/:filename", :ftp_servers => [
            {
                :host => "ftp.vr3.io",
                :user => "admin@vr3.io",
                :password => "Admin123!--"
            }
        ], :ftp_connect_timeout => 5, :ftp_ignore_failing_connections => true, :ftp_keep_empty_directories => true

    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
    validates_attachment_content_type :video, content_type: /\Avideo\/.*\Z/

    Paperclip.interpolates :client do |a,s|
        a.instance.client.downcase
    end

	def slug_candidates
		[:title, [:title, :client], [:title, :client, :provider]]
    end
    
    
end
