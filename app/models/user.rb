class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: {case_sensitive: false}, presence: true
  validates :password, presence: true, length: {minimum: 2}, confirmation: true



  def self.authenticate_with_credentials(email, password)
    no_case_email = email.strip.downcase
    @user = User.find_by(email: no_case_email)
    if @user && @user.try(:authenticate, password)
      @user
    else
      nil
    end
  end
end