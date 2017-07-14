class Project < ApplicationRecord
	

    extend FriendlyId
	friendly_id :slug_candidates, :use => [:slugged, :finders]

	has_attached_file :image, styles: { standard: "562x387>", thumb: "281x194>" }, default_url: "http://static.vr3.io/vr3/img/main/projectmissing.png"
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

    Paperclip.interpolates :client do |a,s|
        a.instance.client.downcase
    end 

    #validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
    #validates_attachment_content_type :video, content_type: /\Avideo\/.*\Z/


	def slug_candidates
		[:title, [:title, :client], [:title, :client, :provider]]
    end
    
end
