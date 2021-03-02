class Article < ActiveRecord::Base
    has_many :users
    has_many :comments, through: :users
end