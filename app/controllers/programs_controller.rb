class ProgramsController < ApplicationController

  before_action :authenticate_user!

  def index
    @programs = Program.all
    authorize @programs
  end

  def show
    @program = Program.find(params[:id])
    authorize @program
  end

  def new
    @program = Program.new
    authorize @program
  end
  
  def create
    @program = Program.new(program_params)
    authorize @program
    if @program.save
      redirect_to(programs_path)
    else
      render("new")
    end
  end

  def edit
    @program = Program.find(params[:id])
    authorize @program
  end
  
  def update
    @program = Program.find(params[:id])
    authorize @program
    if @program.update_attributes(program_params)
      redirect_to(program_path(@program.id))
    end
  end

  def delete
    @program = Program.find(params[:id])
    authorize @program
  end

  def destroy
    @program = Program.find(params[:id])
    authorize @program
    if @program.destroy
      redirect_to(programs_path)
    end
  end

  private

  def program_params
    params.require(:program).permit(:title, :lessons_per_week, :time_table, hours_attributes: [:id, :number, :_destroy],
                                    weeks_attributes: [:id, :number, :cost, :_destroy])
  end
end
