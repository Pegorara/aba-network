class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :commentable, polymorphic: true
    has_many :comments, as: :commentable, dependent: :destroy

    validates :content, presence: true
    validates :user_id, presence: true
    validates :commentable_id, presence: true
    validates :commentable_type, presence: true
end
