class Article < ActiveRecord::Base
  mount_uploader :file, ImageUploader
  validates :title, presence: true,
            length: { minimum: 5 }
  validates :content, presence: true,
            length: { minimum: 10 }
  validates :status, presence: true
  scope :status_active, -> {where(status: 'active')}
  #default_scope {where(status: 'active')}

  #relationship
  has_many :comments, dependent: :destroy
end
