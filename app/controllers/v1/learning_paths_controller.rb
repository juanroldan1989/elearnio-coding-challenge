module V1
  class LearningPathsController < ApplicationController
    def index
      render json: LearningPath.all
    end

    def create
      learning_path = LearningPaths.create(
        title: learning_path_params[:title],
        description: learning_path_params[:description],
        course_ids: params[:course_ids]
      )

      if learning_path.present? && learning_path.errors.empty?
        render json: { learning_path: learning_path, courses: learning_path.courses }, status: 200
      else
        render json: { learning_path: nil, message: learning_path.errors.full_messages }, status: 422
      end
    end

    def update
      learning_path = LearningPath.find(params[:id])
      learning_path.update(learning_path_params)

      render json: {
        learning_path: learning_path.reload,
        courses: learning_path.courses,
        message: learning_path.errors.try(:full_messages)
      }, status: 200
    end

    def destroy
      message = if LearningPath.destroy(params[:id])
        "LearningPath deleted"
      else
        learning_path.errors.full_messages
      end

      render json: { message: message }
    end

    private

    def learning_path_params
      params.require(:learning_path).permit(:title, :description)
    end
  end
end
