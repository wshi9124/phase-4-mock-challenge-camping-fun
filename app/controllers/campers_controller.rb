class CampersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response
    def index
        render json: Camper.all
    end

    def show
        camper= Camper.find(params[:id]) 
        render json: camper, serializer:CamperActivitySerializer
    end

    def create 
        camper= Camper.create!(params_permit)
        render json: camper, status: 201
    end

private
    def params_permit
        params.permit(:name, :age)
    end

    def render_not_found_response
        render json: { error: "Camper not found"}, status: :not_found
    end

    def render_invalid_response(error)
        render json: {errors: error.record.errors.full_messages}, status: 422
    end

end
