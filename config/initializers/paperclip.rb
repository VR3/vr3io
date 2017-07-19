require 'paperclip'
#include Paperclip::Schema
Paperclip::Attachment.default_options[:s3_host_name] = 's3-us-west-2.amazonaws.com'
Paperclip::Attachment.default_options[:url] = ':vr3iodev'
Paperclip::Attachment.default_options[:path] = '/projects/:client/:attachment/:style/:filename'