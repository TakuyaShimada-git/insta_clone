class Favorite < ApplicationRecord
    belongs_to :user
    belongs_to :micropost
    validates :user_id, presence: true
    validates :microposts_id, presence: true
end
