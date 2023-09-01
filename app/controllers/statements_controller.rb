class StatementsController < ApplicationController

  before_action :authenticate_user!

  def delete
    @statement = Statement.find(params[:id])
    authorize @statement
  end

  def destroy
    @statement = Statement.find(params[:id])
    authorize @statement
    type = @statement.type
    if type == 'Invoice'
      @student = Student.find(@statement.student_id)
      @student.update_attributes(:balance => (@statement.student.balance.to_f + (@statement.total_amount - @statement.balance)).to_f)
    end
    if @statement.destroy
      if type == 'Quote'
        redirect_to quotes_path
      elsif type == 'ProForma'
        redirect_to pro_formas_path
      elsif type == 'Invoice'
        redirect_to invoices_path
      else
        redirect_to students_path
      end
    else
      render ('delete')
    end
  end

end
