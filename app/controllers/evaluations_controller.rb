class EvaluationsController < ApplicationController

  before_action :find_student, :assign_study_period
  before_action :authenticate_user!
  after_action :verify_authorized, :except => [], unless: :devise_controller?
  
  def index
    if params[:student_id]
      @evaluations = params[:study_period_id].present? ? @student.study_periods.find(params[:study_period_id]).evaluations : @student.study_periods.last.evaluations.order('created_at DESC')
    else
      @evaluations = Evaluation.order('created_at DESC')
    end

    authorize @evaluations
  end

  def show
    @evaluation = @student.study_periods.last.evaluations.find(params[:id])
    authorize @evaluation
  end

  def new
    @evaluation = Evaluation.new
    authorize @evaluation
  end
  
  def create
    study_period = params[:study_period_id].present? ? @student.study_periods.find(params[:study_period_id]) : @student.study_periods.last
    @evaluation = study_period.evaluations.new(evaluation_params)
    @evaluation.update_attributes(:language => study_period.course_language)
    authorize @evaluation

    if @evaluation.save
      flash[:success] = 'Academic profile (evaluation) created successfully'
      redirect_to(student_path(:id => @student.id))
    else
      flash[:error] = 'Something went wrong. Academic profile (evaluation) not created'
      redirect_to(student_path(:id => @student.id))
    end
  end

  def edit
  end

  def delete
  end

  def destroy
    @evaluation = @study_period.evaluations.find(params[:id])
    authorize @evaluation
    if @evaluation.destroy
      flash[:notice] = 'Evaluation deleted'
      redirect_to student_path(@student.id)
    else
      flash[:notice] = 'Something went wrong. Evaluation was not deleted'
    end
  end


  def report
    @evaluation = @study_period.evaluations.find(params[:id])
    authorize @evaluation
  end

  def exercises
    @evaluation = @study_period.evaluations.find(params[:id])
    authorize @evaluation
  end

  def daily
    @levels = Student.levels
    @evaluation = @study_period.evaluations.find(params[:id])
    authorize @evaluation
  end

  def regular
    @levels = Student.levels
    @evaluation = @study_period.evaluations.find(params[:id])
    authorize @evaluation
  end

  def set_evaluation_to_active
    @evaluation = @study_period.evaluations.find(params[:id])
    authorize @evaluation

    if @evaluation.update(:is_active => params[:is_active])
      flash[:success] = 'Evaluation set to active'
      redirect_to :back
    else
      flash[:error] = 'Evaluation could not be set to active'
      redirect_to :back
    end
  end
  
  private
  
  def evaluation_params
    params.require(:evaluation).permit(:end_date, :is_active)
  end

  def find_student
    if params[:student_id]
      @student = Student.find(params[:student_id])
    end
  end

  def assign_study_period
    if params[:study_period_id].present?
      @study_period = @student.study_periods.find(params[:study_period_id])
    elsif @student.present?
      @study_period = @student.study_periods.last
    end
  end
end
