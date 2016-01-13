class FeedsController < ApplicationController
  before_action :find_all_records, only: [:index]

  def index
    
  end

private

  def find_all_records
    @all_records = Record.all.paginate(page: params[:page], per_page: 20).order(created_at: :desc)
  end
end
