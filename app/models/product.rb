class Product < ApplicationRecord
  validates :title, :description, :image_url, presence: true
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: { with: %r{\.(gif|jpg|png)\Z}i, message: "Must be a URL for GIF, JPG or PNG image!" }
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, length: { minimum: 5, message: "has to be equal or greater than five" }

  has_many :line_items

  before_destroy :ensure_not_references_by_any_items

  private

    def ensure_not_references_by_any_items
      unless line_items.empty?
        errors.add(:base, 'Line items present.')
        throw :abort
      end
    end
    
end
