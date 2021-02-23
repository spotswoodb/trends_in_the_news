class User < ActiveRecord::Base
    has_many :articles
    has_many :categories, through: :articles

    has_secure_password
end