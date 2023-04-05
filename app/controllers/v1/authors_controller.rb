module V1
  class AuthorsController < ApplicationController
    def index
      render json: Author.all
    end

    def create
      author = Author.new(author_params)

      if author.save
        render json: { author: author }, status: 200
      else
        render json: { author: nil, message: author.errors.full_messages }, status: 422
      end
    end

    def update
      author = Author.find(params[:id])
      author.update(author_params)

      render json: { author: author.reload, message: author.errors.try(:full_messages) }, status: 200
    end

    def destroy
      message = Authors.delete(params[:id])

      render json: { message: message }
    end

    private

    def author_params
      params.require(:author).permit(:first_name, :last_name, :talent_id)
    end
  end
end
