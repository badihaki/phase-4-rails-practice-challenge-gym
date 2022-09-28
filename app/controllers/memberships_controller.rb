class MembershipsController < ApplicationController

    def create
        new_membership = Membership.create!(permitted_params)
        render json: new_membership, status: :created
    rescue ActiveRecord::RecordInvalid => invalid
        render json: {errors: invalid.record.errors}, status: :unprocessable_entity
    end

    private
    
    def permitted_params
        params.permit(:gym_id, :client_id, :charge)
    end

end
