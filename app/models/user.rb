class User < ActiveRecord::Base
  # require 'phpass'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def valid_password?(password)
    return false if encrypted_password.blank?
    if encrypted_password[0..3] == '$2y$'
      password_verify password, encrypted_password
    else
      super
    end
  end

  def password_verify(password, hash)
    ret = password.crypt(hash)
    if ret.blank? || ret.length != hash.length || ret.length <= 13
      return false
    end
    status = 0
    i = 0
    while i < ret.length do
      status = (ret[i].ord ^ hash[i].ord) if status == 0
      i += 1
    end
    status === 0
  end
end
