class Category < ActiveRecord::Base
    has_many :users, through: :articles
    has_many :articles
end