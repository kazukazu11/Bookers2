class Book < ApplicationRecord
	belongs_to :user
	validates :title, presence: true
    validates :body, presence: true
    validates :body, length: { maximum: 200 }

    acts_as_ordered_taggable_on :tags
end