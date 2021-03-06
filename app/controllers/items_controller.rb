class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # GET /items
  # GET /items.json
  def index
    page_size = 12
    @page = params[:page].nil? ? 1 :  params[:page].to_i
    @items = current_user.items.all
    @items = @items.where(name: params[:name]) unless params[:name].nil?
    # count total item before paging
    flash[:notice] = "Total item found : #{@items.count}"
    
    @items = @items.limit(page_size).offset((@page.to_i - 1) * page_size).order(date: :desc)
    @total_page = (current_user.items.count / page_size.to_f).ceil

    @paginator_iter_count = (1..10)
    @paginator_iter_count = (@page - 5..@page + 5) if @page >= 10 && @page <= @total_page - 10
    @paginator_iter_count = (@total_page - 10..@total_page) if @page > @total_page - 10

    @item_types = Item.new.item_type_option
  end

  # GET /items/1
  # GET /items/1.json
  def show; end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit; end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
    @item.user = current_user
    @item.date = Parsi::Date.parse(item_params['date']).to_gregorian unless item_params['date'].blank?

    respond_to do |format|
      if @item.save
        format.html { redirect_to items_url, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      params = item_params
      params['date'] = Parsi::Date.parse(item_params['date']).to_gregorian unless item_params['date'].blank?
      if @item.update(params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = current_user.items.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def item_params
    params.require(:item).permit(:name, :price, :date, :user_id, :group_id, :item_type, { tag_ids: [] })
  end
end
