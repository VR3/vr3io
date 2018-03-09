class Project < ApplicationRecord
    require 'paperclip'
    include Paperclip::Glue

    extend FriendlyId
	friendly_id :slug_candidates, :use => [:slugged, :finders]

    # Paperclip
    
    has_attached_file :image, :styles => { standard: "562x387>", thumb: "281x194>" }, :default_url => "https://s3-us-west-2.amazonaws.com/vr3io/projectmissing.png", :storage => :s3, :s3_protocol => 'https', :s3_region => ENV['AWS_REGION'], :bucket => ENV['S3_BUCKET_NAME'], :access_key_id => ENV['AWS_ACCESS_KEY_ID'], :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'], :url => "https://s3-us-west-2.amazonaws.com/vr3io/projects/:client/:attachment/:style/:filename"

    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

    has_attached_file :video, :styles => { :medium => { :geometry => "640x480", :format => 'mp4' }, :thumb => { :geometry => "160x120", :format => 'jpeg', :time => 10 } }, :processors => [:transcoder], :default_url => "https://s3-us-west-2.amazonaws.com/vr3io/projectmissing.png", :storage => :s3, :s3_protocol => 'https', :s3_region => ENV['AWS_REGION'], :bucket => ENV['S3_BUCKET_NAME'], :access_key_id => ENV['AWS_ACCESS_KEY_ID'], :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'], :url => "https://s3-us-west-2.amazonaws.com/vr3io/projects/:client/:attachment/:style/:filename"
    
    validates_attachment_content_type :video, content_type: /\Avideo\/.*\Z/

	def slug_candidates
		[:title, [:title, :client], [:title, :client, :provider]]
    end

    Paperclip.interpolates :client do |attachment, style|
        attachment.instance.client.downcase 
    end

    # Filterrific

    filterrific(
        default_filter_params: { sorted_by: 'created_at_desc' },
        available_filters: [
            :search_query,
            :sorted_by,
            :with_category
        ]
    )

    scope :search_query, lambda { |query|
        # Searches the students table on the 'first_name' and 'last_name' columns.
        # Matches using LIKE, automatically appends '%' to each term.
        # LIKE is case INsensitive with MySQL, however it is case
        # sensitive with PostGreSQL. To make it work in both worlds,
        # we downcase everything.
        return nil if query.blank?
    
        # condition query, parse into individual keywords
        terms = query.downcase.split(/\s+/)
    
        # replace "*" with "%" for wildcard searches,
        # append '%', remove duplicate '%'s
        terms = terms.map { |e|
        (e.gsub('*', '%') + '%').gsub(/%+/, '%')
        }
        # configure number of OR conditions for provision
        # of interpolation arguments. Adjust this if you
        # change the number of OR conditions.
        num_or_conds = 4
        where(
        terms.map { |term|
            "(LOWER(projects.title) LIKE ? OR LOWER(projects.description) LIKE ? OR LOWER(projects.client) LIKE ? OR LOWER(projects.provider) LIKE ?)"
        }.join(' AND '),
        *terms.map { |e| [e] * num_or_conds }.flatten
        )
    }

    scope :with_category, lambda{ |categories|
        where(category: [*categories])
    }

    scope :sorted_by, lambda { |sort_option|
        # extract the sort direction from the param value.
        direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
        case sort_option.to_s
        when /^created_at_/
        order("projects.created_at #{ direction }")
        else
        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
        end
    }

    def self.options_for_select
        [
            ["VR/AR", "vr-ar"], 
            ["AI/ML", "ai-ml"], 
            ["Blockchain", "blockchain"], 
            ["Cryptodivisas", "crypto"], 
            ["Desarrollo", "development"]
        ]
    end
    
  
    
end
