class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def index
        campers = Camper.all
        render json: campers.to_json(only: [:id, :name, :age])
        
    end

    def show
        camper = find_camper
        render json: camper
    end

    def create
        camper = Camper.create!(camper_params)
        render json: camper.to_json(only: [:id, :name, :age]), status: :created
    end


    private

    def camper_params
      params.permit(:name, :age)
    end
    
    def find_camper
      Camper.find(params[:id])
    end

    def render_not_found
        render json: {"error": "Camper not found"},
        status: :not_found
    end

    def record_invalid(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end



end
