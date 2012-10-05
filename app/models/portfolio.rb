class Portfolio < ActiveRecord::Base
  belongs_to :company
  attr_accessible :image, :company_id
  
  has_attached_file :image, {
      :styles         => { :large => "559x339>", :medium => "263x163>", :small => "190x110>",:thumb => "86>x53" },
      :default_style  => :thumb,
      :default_url    => ActionController::Base.helpers.asset_path('side_camera.png')}.merge(PAPERCLIP_STORAGE_OPTIONS)
      
  validates_attachment_content_type :image,
    :content_type =>/image/, :message => "must be image of type: jpeg, jpg or png"
    
  def image_from_url(url)
    self.image = URI.parse(url)
  end
end
