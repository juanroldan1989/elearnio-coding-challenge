module V1
  class TalentLearningPathCoursesController < ApplicationController
    def create
      record = TalentLearningPathCourse.new(record_params)

      if record.save
        render json: { talent_learning_path_course: record }, status: 200
      else
        render json: { talent_learning_path_course: nil, message: record.errors.full_messages }, status: 422
      end
    end

    def update
      record = TalentLearningPathCourses.update_status(params[:id], record_params)

      render json: {
        talent_learning_path_course: record,
        message: record.errors.try(:full_messages)
      }, status: 200
    end

    def destroy
      record = TalentLearningPathCourse.find(params[:id])

      message = if record.destroy
        "Record deleted"
      else
        record.errors.full_messages
      end

      render json: { message: message }
    end

    private

    def record_params
      params.require(:talent_learning_path_course).permit(
        :talent_id, :learning_path_id, :course_id, :course_status
      )
    end
  end
end
