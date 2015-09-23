class UserItemshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user_item, only: [:show, :edit, :update, :destroy]

  def index
    @user_items = current_user.items
  end

  def show
  end

  def new
    @items = Item.all.order("created_at DESC")
    @user_itemship = current_user.user_itemships.build
  end

  def create
    @user_itemship = current_user.user_itemships.build(user_itemship_params)

    if @user_itemship.save
      redirect_to user_itemships_path, notice: "Successfully created new UserItemShip"
    else
      render 'new'
    end
  end

  def destroy
    @user_itemship.destroy
    redirect_to user_itemships_path
  end

private

  def user_itemship_params
    params.require(:user_itemship).permit(:user_id, :item_id)
  end

  def find_user_item
    @user_itemship = UserItemship.find(params[:id])
  end
end
