class Micropost < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favo_users, through: :favorites, source: :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :picture_size
  
  #お気に入りする
  def favo(user)
    favorites.create(user_id: user.id)
  end
  
  #お気に入り解除
  def unfavo(user)
    likes.find_by(user_id: user.id).destroy
  end
  
  # 現在のユーザーがお気に入りしてたらtrueを返す
  def favo?(user)
    favo_users.include?(user)
  end

  private

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
    
    def Micropost.including_replies(user_id)
      # Micropostsテーブルから、下記のいずれか条件の投稿を取得する
      #   自分がフォローしている人
      #   自分のマイクロポスト
      #   返信先が自分になっているマイクロポスト
      following_ids = "SELECT followed_id FROM relationships
                       WHERE follower_id = :user_id"
      Micropost.where("user_id        IN (#{following_ids})
                       OR user_id     =   :user_id
                       OR in_reply_to =   :user_id"         , user_id: user_id)
    end
end