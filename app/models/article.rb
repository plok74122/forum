class Article < ActiveRecord::Base
  belongs_to :article_type
  belongs_to :user
  has_many :comments
  has_many :likes
  has_many :likes_users , :through => :likes , :source => :user

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/


  def finy_like_by(user)
    self.likes.find_by_user_id( user.id )
  end
end
