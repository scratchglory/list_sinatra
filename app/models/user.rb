# validate some of the attributes of our user
# making sure that no one can sign up without inputting their name, email, and passowrd
class User < ActiveRecord::Base
    has_secure_password
    has_many :items
    # validates :email, uniqueness: true
    # validates :username, uniqueness: true
end
