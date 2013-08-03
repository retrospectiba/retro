class Retrospectives::BadsController < ApplicationController
  before_filter :ensure_authentication

  def create
    bad = Bad.new(params[:bad])
    if bad.valid?
      bad.save
    else
      flash[:error] = bad.errors.full_messages
    end
    redirect_to retrospective_path(params[:retrospective_id])
  end

  def keep
    bad = Bad.find(params[:id])
    bad.retrospective_id = params[:retrospective_id]
    bad.keep!
    raise RuntimeError, 'Erro ao salvar post-it' unless bad.save
    redirect_to retrospective_path(params[:retrospective_id])
  end

  def to_good
    bad = Bad.find(params[:id])
    good = Good.new
    good.retrospective_id = params[:retrospective_id]
    good.description = "Corrigido: #{bad.description}!"
    good.save
    bad.destroy
    redirect_to retrospective_path(params[:retrospective_id])
  end

  def destroy
    bad = Bad.find(params[:id])
    bad.destroy
    respond_to do |format|
      format.json { render :json => bad }
    end
  end

  def update
    bad = Bad.find(params[:id])
    if bad.update_attributes(params[:bad])
      head :ok
    else
      head :error
    end
  end

  def similar_retro_items
    search_words  = params[:q].split(' ').select {|word| word.size > 2}.uniq
    results_array = {}

    search_words.each do |word|
      Bad.where('retrospective_id = ? AND description LIKE (?)', params[:retrospective_id], "%#{word}%").collect do |item|
        results_array[item] = results_array[item].to_i + 1
      end
    end

    @retro_items = results_array.sort_by {|item, quantity| quantity}.reverse

    head :not_found and return if @retro_items.blank?
    render template: 'retrospectives/similar_retro_items', layout: false
  end
end
