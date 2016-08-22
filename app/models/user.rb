class User < ActiveRecord::Base
    before_save { self.email = self.email.downcase}
    validates :name, presence: true, length: { maximum: 50}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
    
    
    
    validates :profile, absence: true, 
                       on: :create
    validates :profile, allow_blank: true, 
                       length: { minimum: 2, maximum: 200 }, 
                       on: :update
    has_secure_password
    has_many :microposts


   has_many :following_relationships, class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
   has_many :following_users, through: :following_relationships, source: :followed 
#フォローしている人を探す    

   has_many :follower_relationships, class_name:  "Relationship",
                                     foreign_key: "followed_id",
                                     dependent:   :destroy
   has_many :follower_users, through: :follower_relationships, source: :follower

 # 他のユーザーをフォローする
  def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end

  # フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
  end

  # あるユーザーをフォローしているかどうか？
  def following?(other_user)
    following_users.include?(other_user)
  end
end


# 2行目で、データの保存前にメールアドレスのアルファベットを小文字にする。
#before_saveはコールバックと呼ばれ、データの保存が行われる前に指定したブロックまたはメソッドの処理が実行されます。
#•4行目のVALID_EMAIL_REGEXでメールアドレスの正規表現パターンを定義しています。（正規表現についてはここでは理解しなくも大丈夫です。）

#•5〜7行目で、emailは空でなく、255文字以内で、VALID_EMAIL_REGEXのパターンに一致し、他と異なるようにバリデーションを行っています。
