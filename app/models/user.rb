class User < ApplicationRecord
    before_create :set_remember_token
    has_many :posts
    
    has_secure_password

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
