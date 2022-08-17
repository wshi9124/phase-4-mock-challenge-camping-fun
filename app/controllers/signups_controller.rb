class SignupsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :response_record_invalid

    def create
        signup= Signup.create!(params_permit)
        render json: signup.activity, status: 201
    end

    private 
    def params_permit
        params.permit(:time, :camper_id, :activity_id )
    end

    def response_record_invalid(error)
        render json: {errors: error.record.errors.full_messages}, status: 422
    end
end
