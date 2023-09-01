class PaymentsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_student

  def index
    if params[:student_id]
      @payments = @student.payments.all
    else
      @payments = Payment.all
    end
    authorize @payments
  end

  def delete
    @payment = Payment.find(params[:id])
    authorize @payment
  end

  def destroy
    @payment = Payment.find(params[:id])
    authorize @payment
    if @payment.destroy
      redirect_to(:action => :index)
    else
      render("delete")
    end
  end

  private

  def find_student
    if params[:student_id]
      @student = Student.find(params[:student_id])
    end
  end

end
