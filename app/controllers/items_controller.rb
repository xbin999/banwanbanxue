class ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      respond_to do |format|
        format.js {}
        format.html {redirect_to user_itemships_path, notice: "Successfully created new Item."}
      end
    else
      render 'new'
    end
  end

private
  def item_params
    params.require(:item).permit(:id, :title, :description)
  end

end
