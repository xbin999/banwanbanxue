class FeedsController < ApplicationController
  before_action :find_all_records, only: [:index]
  
  def index
    
  end

private

  def find_all_records
    @all_records = Record.all.order(created: :desc)
  end
end
