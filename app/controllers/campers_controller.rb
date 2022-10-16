class CampersController < ApplicationController

    # rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        campers = Camper.all 
        render json: campers
    end

    def show
        camper = find_camper
        # displaying individual campers with CamperserializerSerializer
        render json: camper, serializer: CamperserializerSerializer, status: :ok
    end

    def create 
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    rescue ActiveRecord::RecordInvalid => invalid
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    private
    def find_camper
        Camper.find(params[:id])
    end

    def render_not_found_response
        render json: {error: "Camper not found"}, status: :not_found
    end

    def camper_params
        params.permit(:name, :age)
    end

    # def render_unprocessable_entity(invalid)
    #     render json: { error: invalid.record.errors.full_messages }, status: :unprocessable_entity
    # end
    

end
