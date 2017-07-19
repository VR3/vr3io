require 'paperclip'
#include Paperclip::Schema
Paperclip::Attachment.default_options[:s3_host_name] = 's3-us-west-2.amazonaws.com'
Paperclip::Attachment.default_options[:url] = ':vr3io'
Paperclip::Attachment.default_options[:path] = '/projects/:client/:attachment/:style/:filename'
\Paperclip::Attachment.default_options[:region] = 'us-west-2'