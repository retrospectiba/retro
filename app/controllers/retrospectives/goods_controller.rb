class Retrospectives::GoodsController < ApplicationController
  before_filter :ensure_authentication

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
    search_words = params[:q].split(" ").select {|word| word.size > 2}
    results_array = []

    search_words.each do |sw|
      Good.where('retrospective_id = ? AND description LIKE (?)', params[:retrospective_id], "%#{sw}%").collect { |result| results_array << result }
    end
    retro_items  = results_array.inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }.sort {|x,y| y <=>x}

    render json: retro_items
  end
end
