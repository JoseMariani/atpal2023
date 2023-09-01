class QuizzesController < ApplicationController

  before_action :authenticate_user!
  before_action :find_evaluation
  
  def index
    if params[:evaluation_id]
      @quizzes = @evaluation.quizzes.newest_first
    else
      @quizzes = Quiz.newest_first
    end
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "quizzes.pdf",
               :template => "quizzes/index.pdf.erb",
               :layout => "pdf_layout.html",
               :page_size => "Letter",
               :orientation => 'Landscape',
               :javascript_delay => 3000,
               margin:  {   top:               5,                     # default 10 (mm)
                            bottom:            5,
                            left:              10,
                            right:             10 }
      end
    end
    authorize @quizzes
  end

  def show
    if params[:evaluation_id]
      @quiz = @evaluation.quizzes.find(:id)
    else
      @quiz = Quiz.find(params[:id])
    end
    authorize @quiz
  end

  def new
    if params[:evaluation_id]
      @quiz = @evaluation.quizzes.new(quiz_params)
    else
      @quiz = Quiz.new(quiz_params)
    end
    authorize @quiz
  end
  
  def create
    if params[:evaluation_id]
      @quiz = @evaluation.quizzes.new(quiz_params)
    else
      @quiz = Quiz.new(quiz_params)
    end
    authorize @quiz
    if @quiz.save
      respond_to do |format|
        format.html {redirect_to(:controller => :students, :action => :index)}
        format.js 
      end
    end
  end

  def edit
    if params[:evaluation_id]
      @quiz = @evaluation.quizzes.find(params[:id])
    else
      @quiz = Quiz.find(params[:id])
    end
    authorize @quiz
    respond_to do |format|
      format.html {redirect_to(:controller => :students, :action => :index)}
      format.js
    end
  end
  
  def update
    if params[:evaluation_id]
      @quiz = @evaluation.quizzes.find(params[:id])
    else
      @quiz = Quiz.find(params[:id])
    end
    authorize @quiz
    if @quiz.update_attributes(quiz_params)
      respond_to do |format|
        format.html {redirect_to(:controller => :students, :action => :index)}
        format.js 
      end
    end
  end

  def delete
    if params[:evaluation_id]
      @quiz = @evaluation.quizzes.find(:id)
    else
      @quiz = Quiz.find(params[:id])
    end
    authorize @quiz
  end
  
  def destroy
    if params[:evaluation_id]
      @quiz = @evaluation.quizzes.find(:id)
    else
      @quiz = Quiz.find(params[:id])
    end
    authorize @quiz
    if @quiz.destroy
      flash[:success] = 'Quiz destroyed successfully'
      redirect_to :back
    else
      flash[:error] = @quiz.errors.full_messages
      redirect_to :back
    end
  end
  
  private
  
  def quiz_params
    params.require(:quiz).permit(:date, :chapter, :letter_grade, :grade_percentage)
  end
  
  def find_evaluation
    if params[:evaluation_id]
      @evaluation = Evaluation.find(params[:evaluation_id])
    end
  end
  
end
