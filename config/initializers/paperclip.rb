if Rails.env == 'test'
  ::PAPERCLIP_STORAGE_OPTIONS = { :storage => :filesystem,
  																:url		 => '/:class/:attachment/:id/:style/:filename',
                                  :path    => "#{Rails.root}/public/:class/:attachment/:id/:style/:filename"}

else
  ::PAPERCLIP_STORAGE_OPTIONS = {
    :storage        => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :path           => ":class/:attachment/:id/:style/:filename" }
end
