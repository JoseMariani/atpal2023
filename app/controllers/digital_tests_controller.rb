class DigitalTestsController < ApplicationController

  before_action :authenticate_user!

  def index
    @digital_tests = DigitalTest.order('created_at DESC')
    authorize @digital_tests
  end

  def show
    @digital_test = DigitalTest.find(params[:id])
    authorize @digital_test
  end

  def new
    @digital_test = DigitalTest.new
    @levels = Student.levels
    authorize @digital_test
  end

  def create
    @digital_test = DigitalTest.new(digital_test_params)
    authorize @digital_test
    if @digital_test.save
      redirect_to digital_tests_path
    else
      render("new")
    end
  end

  def delete
    @digital_test = DigitalTest.find(params[:id])
    authorize @digital_test
  end

  def destroy
    @digital_test = DigitalTest.find(params[:id])
    authorize @digital_test
    if @digital_test.destroy
      redirect_to digital_tests_path
    else
      render("delete")
    end
  end

  private

  def digital_test_params
    params.require(:digital_test).permit(:level, :attachment)
  end

end
