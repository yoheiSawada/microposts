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
end

# 2行目で、データの保存前にメールアドレスのアルファベットを小文字にする。
#before_saveはコールバックと呼ばれ、データの保存が行われる前に指定したブロックまたはメソッドの処理が実行されます。
#•4行目のVALID_EMAIL_REGEXでメールアドレスの正規表現パターンを定義しています。（正規表現についてはここでは理解しなくも大丈夫です。）

#•5〜7行目で、emailは空でなく、255文字以内で、VALID_EMAIL_REGEXのパターンに一致し、他と異なるようにバリデーションを行っています。
