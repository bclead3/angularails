class ItemsController < ApplicationController

  def index_render
    render 'index'
  end

  def index
    @items = Item.all
    #respond_to do |format|
    #  format.json { render(:json => @items) }
    #  #format.html { render }
    #end
    render(:json => @items)
  end

  def show
    @item = get_item
    if @item
      render(:json => @item)
    else
      head 404
    end
  end

  def create
    @item = Item.new(params[:item])
    if @item.save
      render(:json => @item, :status => :created, :location => item_url(@item))
    else
      errors = @item.errors || ['invalid data']
      render(:json => errors, :status => :unprocessable_entity)
    end
  end

  def update
    @item = get_item
    if @item && @item.update_attributes(params[:item])
      head 204
    elsif @item
      errors = @item.errors || ['invalid data']
      render(:json => errors, :status => :unprocessable_entity)
    else
      head 404
    end
  end

  def destroy
    @item = get_item
    if @item && @item.destroy
      head 204
    elsif @item
      head 422
    else
      head 404
    end
  end

  protected

  def get_item
    Item.find_by_id(params[:id])
  end
end
