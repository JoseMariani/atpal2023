class TestsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_evaluation
  
  def index
    if params[:evaluation_id]
      @tests = @evaluation.tests.newest_first
    else
      @tests = Test.newest_first
    end
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "tests.pdf",
               :template => "tests/index.pdf.erb",
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
    authorize @tests
  end

  def show
    if params[:evaluation_id]
      @test = @evaluation.tests.find(:id)
    else
      @test = Test.find(params[:id])
    end
    authorize @test
  end

  def new
    if params[:evaluation_id]
      @test = @evaluation.tests.new
    else
      @test = Test.new
    end
    @levels = Student.levels
    authorize @test
  end
  
  def create
    if params[:evaluation_id]
      @test = @evaluation.tests.new(test_params)
    else
      @test = Test.new(test_params)
    end
    authorize @test
    if @test.save
      respond_to do |format|
        format.html {redirect_to tests_path(:id => @test.id, :evaluation_id => @test.evaluation.id)}
        format.js 
      end
    end
  end

  def edit
    if params[:evaluation_id]
      @test = @evaluation.tests.find(params[:id])
    else
      @test = Test.find(params[:id])
    end
    @levels = Student.levels
    authorize @test
  end
  
  def update
    if params[:evaluation_id]
      @test = @evaluation.tests.find(params[:id])
    else
      @test = Test.find(params[:id])
    end
    authorize @test
    if @test.update_attributes(test_params)
      respond_to do |format|
        format.html {redirect_to tests_path(:id => @test.id, :evaluation_id => @test.evaluation.id)}
        format.js
      end
    else
      render ('edit')
    end
  end
  

  def delete
    if params[:evaluation_id]
      @test = @evaluation.tests.find(:id)
    else
      @test = Test.find(params[:id])
    end
    authorize @test
  end
  
  def destroy
    if params[:evaluation_id]
      @test = @evaluation.tests.find(:id)
    else
      @test = Test.find(params[:id])
    end
    authorize @test
    if @test.destroy
      redirect_to(:controller => :students, :action => :index)
    end
  end
  
  private
  
  def test_params
    params.require(:test).permit(:date, :level, :letter_grade, :grade_percentage, :attachment, :remove_attachment)
  end
  
  def find_evaluation
    if params[:evaluation_id]
      @evaluation = Evaluation.find(params[:evaluation_id])
    end
  end
  
end
