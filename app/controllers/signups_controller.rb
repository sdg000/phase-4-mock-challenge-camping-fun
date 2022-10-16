class SignupsController < ApplicationController

    # rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity


    def create
        signup = Signup.create!(signup_params)
        render json: signup.activity, status: :created
    rescue ActiveRecord::RecordInvalid => invalid
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity

    end


    private

    def find_signup
        Signup.find(params[:id])
    end

    def signup_params
        params.permit(:camper_id, :activity_id, :time)
    end

    # def render_unprocessable_entity(invalid)
    #     render json: { error: invalid.record.errors }, status: :unprocessable_entity
    # end


end
