class Retrospectives::GoodsController < ApplicationController
  before_filter :ensure_authentication

  def index
    @retrospective = Retrospective.find(params[:retrospective_id])
    render 'retrospectives/_list_goods', layout: false
  end

  def create
    good = Good.new(params[:good])
    if good.valid?
      good.save
    else
      flash[:error] = good.errors.full_messages
    end
    redirect_to retrospective_path(params[:retrospective_id])
  end

  def destroy
    good = Good.find(params[:id])
    good.destroy
    respond_to do |format|
       format.json { render :json => good }
    end
  end

  def update
    good = Good.find(params[:id])
    if good.update_attributes(params[:good])
      head :ok
    else
      head :error
    end
  end

  def similar_retro_items
    search_words  = params[:q].split(' ').select {|word| word.size > 2}.uniq
    results_array = {}

    search_words.each do |word|
      Good.where('retrospective_id = ? AND description LIKE (?)', params[:retrospective_id], "%#{word}%").collect do |item|
        results_array[item] = results_array[item].to_i + 1
      end
    end

    @retro_items = results_array.sort_by {|item, quantity| quantity}.reverse

    head :not_found and return if @retro_items.blank?
    render template: 'retrospectives/similar_retro_items', layout: false
  end
end
