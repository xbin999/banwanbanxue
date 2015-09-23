class UserItemship < ActiveRecord::Base
  belongs_to :user
  belongs_to :item

  validates_presence_of :user_id, :item_id
  validates_uniqueness_of :item_id, :scope => :user_id
end
