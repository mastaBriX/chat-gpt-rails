class User < ApplicationRecord
  before_validation :downcase_username_and_email

  has_secure_password validations: true

  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: {minimum: 4, maximum: 20}

  private
  def downcase_username_and_email
    self.username = username.downcase if username.present?
    self.email = email.downcase if email.present?
  end
end
