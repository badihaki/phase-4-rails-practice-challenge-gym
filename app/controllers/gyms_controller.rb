class GymsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

    def show
        gym = find_gym
        render json: gym, status: :found
    end

    def index
        render json: Gym.all, status: :ok
    end

    def destroy
        gym = find_gym
        gym.destroy
        head :no_content
    end

    def update
        gym = find_gym
        gym.update!(permitted_params)
        render json: gym, status: :accepted
    end

    private
    
    def find_gym
        Gym.find(params[:id])
    end
    
    def permitted_params
        params.permit(:name, :address)
    end

    def not_found_response
        render json: {errors: "Gym not found"}, status: :not_found
    end
end
