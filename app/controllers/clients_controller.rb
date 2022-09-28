class ClientsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

    def show
        client = find_client()
        render json: client, status: :found
    end

    def index
        render json: Client.all, status: :ok
    end

    def update
        client = find_client()
        client.update!(permitted_params)
        render json: client, status: :accepted
    end

    private
    
    def find_client
        Client.find(params[:id])
    end

    def permitted_params
        params.permit(:name, :age)
    end

    def not_found_response
        render json: {errors: "Client not found"}, status: :not_found
    end

end
