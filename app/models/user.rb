class User < ApplicationRecord

    before_create :set_remember_token

    validates :name, presence: true, length: {maximum: 50}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: {maximum: 255}, 
                      format: {with: VALID_EMAIL_REGEX}, 
                      uniqueness: {case_sensitive: false}
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    has_many :posts

    def set_token
        self.remember_token = User.get_token
    end
    def User.create_token
        SecureRandom.urlsafe_base64.to_s
    end

    def User.get_token
        Digest::SHA1.hexdigest SecureRandom.urlsafe_base64.to_s
    end

end
