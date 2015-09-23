class Record < ActiveRecord::Base
  belongs_to :user
  belongs_to :item

  validates_presence_of :value, :user_id, :item_id
  validates_numericality_of :value, :greater_than_or_equal_to => 0
end
