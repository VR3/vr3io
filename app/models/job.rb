class Job < ApplicationRecord
  include Paperclip::Glue
  extend FriendlyId

  friendly_id :slug_candidates, use: [:slugged, :finders]

  has_attached_file :picture, :styles => { standard: "562x387>", thumb: "281x194>" }, :default_url => "https://s3-us-west-2.amazonaws.com/vr3io/projectmissing.png", :storage => :s3, :s3_protocol => 'https', :s3_region => ENV['AWS_REGION'], :bucket => ENV['S3_BUCKET_NAME'], :access_key_id => ENV['AWS_ACCESS_KEY_ID'], :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'], :url => "https://s3-us-west-2.amazonaws.com/vr3io/jobs/:position/:attachment/:style/:filename"
  
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/  

  def slug_candidates
    [[:position, :location], :position]
  end

  Paperclip.interpolates :position do |attachment, style|
    attachment.instance.position.downcase 
  end

end

