module V1
  class TalentsController < ApplicationController
    def index
      render json: Talent.all
    end

    def create
      talent = Talent.new(talent_params)

      if talent.save
        render json: { talent: talent }, status: 200
      else
        render json: { talent: nil, message: talent.errors.full_messages }, status: 422
      end
    end

    def show
      talent = Talent.find(params[:id])

      if talent.present?
        render json: { talent: talent }, status: 200
      else
        render json: { talent: nil, message: "Talent not found" }, status: 404
      end
    end

    def update
      talent = Talent.find(params[:id])
      talent.update(talent_params)

      render json: { talent: talent.reload, message: talent.errors.try(:full_messages) }, status: 200
    end

    def destroy
      talent = Talent.find(params[:id])

      message = if talent.destroy
        "Talent deleted"
      else
        talent.errors.full_messages
      end

      render json: { message: message }
    end

    private

    def talent_params
      params.require(:talent).permit(:first_name, :last_name)
    end
  end
end
