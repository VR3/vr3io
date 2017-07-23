class Article < ApplicationRecord
    include Paperclip::Glue

    extend FriendlyId
    friendly_id :source,  use: :slugged
    
    has_attached_file :logo, :styles => { standard: "200x300>", thumb: "100x150>" }, :default_url => "https://s3-us-west-2.amazonaws.com/vr3io/projectmissing.png", :storage => :s3, :s3_region => ENV['AWS_REGION'], :bucket => ENV['S3_BUCKET_NAME'], :access_key_id => ENV['AWS_ACCESS_KEY_ID'], :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'], :url => "https://s3-us-west-2.amazonaws.com/vr3io/articles/:source/:attachment/:style/:filename"

    validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

    Paperclip.interpolates :source do |a,s|
       a.instance.created_at.try.(:source.downcase)
    end

end
