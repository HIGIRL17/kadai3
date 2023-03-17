class Book < ApplicationRecord
    belongs_to :user
    has_one_attached :image
    
    validates :title, presence: true
    validates :body, presence: true
    validates :body, length: { maximum: 200 }
    
    def get_image
      if image.attached?
        image
      else
      'no_image.jpg'
      end
    end
end
