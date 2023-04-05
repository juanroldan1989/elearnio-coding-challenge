module V1
  class CoursesController < ApplicationController
    def index
      render json: Course.all
    end

    def create
      course = Course.new(course_params)

      if course.save
        render json: { course: course }, status: 200
      else
        render json: { course: nil, message: course.errors.full_messages }, status: 422
      end
    end

    def update
      course = Course.find(params[:id])
      course.update(course_params)

      render json: { course: course.reload, message: course.errors.try(:full_messages) }, status: 200
    end

    def destroy
      message = if Course.destroy(params[:id])
        "Course deleted"
      else
        course.errors.full_messages
      end

      render json: { message: message }
    end

    private

    def course_params
      params.require(:course).permit(:title, :description, :author_id)
    end
  end
end