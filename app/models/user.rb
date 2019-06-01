class User < ApplicationRecord
    include BCrypt
    validates :email, presence: true, uniqueness: true
    validate :valid_email
    
    has_many :assets
    
    def password
        @password ||= Password.new(password_hash)
    end
    
    def password=(new_password)
        @password = Password.create(new_password)
        self.password_hash = @password
    end
    
    private
    
    def valid_email
        errors.add(:email, "must have an '@' and a '.'") if email.nil? || !(email.include? '@') || !(email.include? '.')
    end
end
