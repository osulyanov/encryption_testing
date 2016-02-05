class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def valid_password?(password)
    return false if encrypted_password.blank?
    enc = encrypted_password
    enc[0..3] = '$2a$' if encrypted_password[0..3] == '$2y$'
    my_password = BCrypt::Password.new(enc)
    my_password == password
  end
end
