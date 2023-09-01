class FixedDurationProgramsController < ApplicationController
  def index
    @fixed_duration_programs = FixedDurationProgram.all
    authorize @fixed_duration_programs
  end

  def show
    @fixed_duration_program = FixedDurationProgram.find(params[:id])
    authorize @fixed_duration_program
  end

  def new
    @fixed_duration_program = FixedDurationProgram.new
    authorize @fixed_duration_program
  end

  def create
    @fixed_duration_program = FixedDurationProgram.new(fd_program_params)
    authorize @fixed_duration_program
    if @fixed_duration_program.save
      redirect_to(fixed_duration_programs_path)
    else
      render("new")
    end
  end

  def edit
    @fixed_duration_program = FixedDurationProgram.find(params[:id])
    authorize @fixed_duration_program
  end

  def update
    @fixed_duration_program = FixedDurationProgram.find(params[:id])
    authorize @fixed_duration_program
    if @fixed_duration_program.update_attributes(fd_program_params)
      redirect_to(fixed_duration_program_path(@fixed_duration_program.id))
    end
  end

  def delete
    @fixed_duration_program = FixedDurationProgram.find(params[:id])
    authorize @fixed_duration_program
  end

  def destroy
    @fixed_duration_program = FixedDurationProgram.find(params[:id])
    authorize @fixed_duration_program
    if @fixed_duration_program.destroy
      redirect_to(fixed_duration_programs_path)
    end
  end

  private

  def fd_program_params
    params.require(:fixed_duration_program).permit(:name, :cost, :duration_weeks, :time_table, :promo_ids => [])
  end
end
