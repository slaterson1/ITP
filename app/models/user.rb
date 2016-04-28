class User < ActiveRecord::Base
  has_many :itineraries
  has_secure_password

  validates :email, presence: true, uniqueness: true,
  format: {
    with: /.+\@.+\..+/,
    message: "USE VALID EMAIL FORMAT."
  }
  validates :auth_token, presence: true
  validates :first, presence: true
  validates :last, presence: true

  def ensure_auth_token
		unless self.auth_token
			self.auth_token = User.generate_token
		end
	end

	def self.generate_token
		token = SecureRandom.hex
		while User.exists?(auth_token: token)
			token = SecureRandom.hex
		end
		token
	end
end
