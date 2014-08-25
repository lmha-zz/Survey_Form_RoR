class SurveysController < ApplicationController
  before_action :set_survey, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @survey = Survey.new
    if(session[:count].blank?)
      session[:count] = 0;
    end
  end

  def show
  end

  def create
    @survey = Survey.new(survey_params)
    respond_to do |format|
      if @survey.save
        session[:count] += 1
        format.html { redirect_to @survey, notice: "Thanks for submitting this form! You have submitted this form #{session[:count]} times now." }
        format.json { render action: 'show', status: :created, location: @survey }
      else
        format.html { render action: 'new' }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def set_survey
    @survey = Survey.find(params[:id])
  end
  def survey_params
    params.require(:survey).permit(:name, :location, :language, :comment)
  end
end
