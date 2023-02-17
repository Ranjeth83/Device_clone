class User < ApplicationRecord
    has_one_attached :header_image
    attr_accessor :password

    validates :first_name,presence: true
    validates :email, uniqueness: true, length: { in: 5..30 }
    validates :password, presence: true,confirmation: true, length: { in: 8..16 }, on: :create
    validates :mobile, length: {is: 10, message: "number invalid"}

    before_save :encrypt_password

    def self.authenticate(email,password)
        user = find_by_email(email)
        return user if user && user.authenticated_password(password)
    end

    def authenticated_password(password)
        self.encrypted_password == encrypt(password)
    end
    
    protected
    def encrypt_password
        return if password.blank?
        self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
        Digest::SHA1.hexdigest(string)
    end
end
