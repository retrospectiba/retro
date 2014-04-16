# encoding : utf-8
class TeamsController < ApplicationController

  before_filter :ensure_authentication

  # GET /teams
  # GET /teams.json
  def index
    @user = current_user
    @teams = Team.order(:name)

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def new
    @team = Team.new
    @users = User.order(:name)
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(params[:team])
    @users = User.order(:name)
    respond_to do |format|
      if @team.save
        format.html { redirect_to teams_path, notice: 'Seu time foi criado!' }
      else
        format.html { render action: "new", layout: false }
      end
    end
  end

  # GET /teams/1/edit
  def edit
    @team = Team.find(params[:id])
    @users = User.order(:name)
  end

  def update
    @team = Team.find(params[:id])
    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to teams_path, notice: 'Seu time foi alterado!' }
      else
        format.html { render action: "edit", layout: false }
      end
    end
  end

  # GET /teams/members/1
  def members
    @team = Team.find(params[:id])
  end
end
