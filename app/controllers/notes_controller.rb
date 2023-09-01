class NotesController < ApplicationController

  before_action :authenticate_user!
  before_action :find_student

  def new
    if params[:student_id]
      @note = @student.notes.new
    else
      @note = Note.new
    end
    authorize @note
  end

  def create
    if params[:student_id]
      @note = @student.notes.new(note_params)
    else
      @note = Note.new(note_params)
    end
    authorize @note
    if @note.save
      respond_to do |format|
        format.js
      end
    else
      flash[:alert] = 'Note could not be saved'
    end
  end

  def delete
  end

  def destroy
    @note = @student.notes.find(params[:id])
    authorize @note
    if @note.destroy
      respond_to do |format|
        format.html
        format.js
      end
    else
      flash[:alert] = 'Note could not be saved'
      redirect_to student_path(:id => @student.id)
    end
  end

  private

  def note_params
    params.require(:note).permit(:student_id, :text)
  end

  def find_student
    if params[:student_id]
      @student = Student.find(params[:student_id])
    end
  end
end
