class RecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user_items
  before_action :find_user_records, only: [:index, :stat]

  def index
    @map = DateUserItemshipMap.new(current_user, @user_items, @user_records)
  end

  def show
  end

  def new
    @user_records = Record.paginate(page: params[:page], per_page: 15).order('created DESC')
    @new_record = Record.new
  end

  def create
    @record = current_user.records.build(record_params)

    if @record.save
      render :partial => "records/record", :locals => { :record => @record }, :layout => false, :status => :created
      # redirect_to records_path, notice: "Successfully created new record"
    else
      # render 'new'
      render :js => "alert('error saving record');"
    end
  end

  def destroy
    @record = Record.find(params[:id]) 
    if @record.destroy 
      render :json => @record, :status => :ok 
    else 
      render :js => "alert('error deleting record');" 
    end
  end

  def stat
    @map = DateUserItemshipMap.new(current_user, @user_items, @user_records)
  end

private
  def record_params
    params.require(:record).permit(:value, :created, :description, :item_id, :user_id)
  end

  def find_user_items
    @user_items = current_user.items
  end

  def find_user_records
    @user_records = current_user.records.order(created: :desc)
  end
end
