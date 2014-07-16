# encoding : utf-8
class RetrospectivesController < ApplicationController

  before_filter :ensure_authentication

  # GET /retrospectives
  # GET /retrospectives.json
  def index
    @user = current_user

    conditions = ""

    conditions += "team_id =  #{@user.team_id} "            if !@user.admin?
    conditions += "team_id =  #{params[:team_id]} "         if !params[:team_id].blank?
    conditions += " AND "                                   if !conditions.blank? && !params[:retro_name].blank?
    conditions += "name    like '%#{params[:retro_name]}%'" if !params[:retro_name].blank?

    @teams = Team.find(:all, conditions: !@user.admin? ? "user_id = #{@user.id}" : "", order: :name)

    @retrospectives = Retrospective.find(:all, conditions: conditions, order: "start_at desc")

    @retrospective = Retrospective.new
  end

  def create
    retrospective = Retrospective.new(params[:retrospective])

    if retrospective.save
      flash[:notice] = 'Sua nova retro foi criada!'
    else
      flash[:error] = retrospective.errors.full_messages
    end

    redirect_to retrospectives_path
  end

  def update
    @retrospective = Retrospective.find(params[:id])
    @retrospective.update_attributes(params[:retrospective])
    head :ok
  end

  # GET /retrospectives
  # GET /retrospectives.json
  def show
    @retrospective = Retrospective.find(params[:id])
    @worst = Retrospective.where("id < #{params[:id]} and team_id = '#{@retrospective.team_id}'").order('created_at desc').first
    @good = Good.new
    @bad  = Bad.new
  end

  def preview_email
    @retrospective = Retrospective.find(params[:id])
    @worst = Retrospective.where(:id => params[:id]).first
    render '/retrospective_mailer/retrospective_resume.html.erb', :layout => 'mail'
  end

  def send_email
    begin
      RetrospectiveMailer.retrospective_resume(params[:id]).deliver
      flash[:notice] = 'Mensagem enviada com sucesso'
    rescue
      flash[:error] = 'Um erro ocorreu! Abra um chamado aê, leke!'
    end

    redirect_to retrospective_path(params[:id])
  end
end
