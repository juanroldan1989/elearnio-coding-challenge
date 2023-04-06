module V1
  class TalentCoursesController < ApplicationController
    def create
      talent_course = TalentCourse.new(talent_course_params)

      if talent_course.save
        render json: {
          message: "Talent ##{talent_course.talent_id} associated with Course ##{talent_course.course_id}"
        }, status: 200
      else
        render json: { message: talent_course.errors.full_messages }, status: 422
      end
    end

    def destroy
      talent_course = TalentCourse.where(
        talent_id: params[:talent_id],
        course_id: params[:course_id]
      ).first

      message = if talent_course.destroy
        "Talent ##{params[:talent_id]} removed from Course ##{params[:course_id]}"
      else
        talent_course.errors.full_messages
      end

      render json: { message: message }
    end

    private

    def talent_course_params
      params.require(:talent_course).permit(:talent_id, :course_id)
    end
  end
end
