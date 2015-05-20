require 'file_size_validator'
class Image < ActiveRecord::Base
  mount_uploader :url, ImageUploader
  #validates :url, :file_size => { :maximum => 200.kilobytes.to_i }
  #validate :image_size_validation, :if => "url:"
  validates :url, 
    :presence => true, 
    :file_size => { 
      :maximum => 0.2.megabytes.to_i 
    } 
  #def image_size_validation
     #if url.size > 200.kilobytes
       #errors.add(:base, "Image should be less than 200 kb")
     #end
  #end
end
