class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  #before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @items = Item.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 8)
  end

  def show
  end

  def new
    @item = current_user.items.build
  end

  def edit
  end

  def edit_index
     @items = Item.all.order("created_at DESC")
  end

  def create
    @item = current_user.items.build(item_params)

    if @item.save
      redirect_to @item, notice: 'Item was successfully created.' 
    else
      render action: 'new' 
    end
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: 'Item was successfully updated.'
    else
      render action: 'edit' 
    end
  end

  def destroy
    @item.destroy
      redirect_to items_url 
  end

  private
 
    def set_item
      @item = Item.find(params[:id])
    end

    def correct_user
      @item = current_user.items.find_by(id: params[:id])
      redirect_to items_path, notice: "Not authorized to edit this item" if @item.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:description, :image)
    end
end
