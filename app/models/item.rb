class Item < ActiveRecord::Base
  has_many :records
  has_many :user_itemships 
  has_many :users, :through => :user_itemships
  
  validates_presence_of :title
  validates_uniqueness_of :title
end
