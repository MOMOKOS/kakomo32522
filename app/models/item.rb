class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :drink
  belongs_to :scene
  belongs_to :allergy
  belongs_to :day

  with_options numericality: { other_than: 1, message: 'Select' } do
    validates :category_id, :drink_id, :scene_id, :allergy_id, :day_id
  end
end
