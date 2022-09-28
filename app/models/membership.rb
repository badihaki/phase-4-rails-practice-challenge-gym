class Membership < ApplicationRecord
    # associations
    belongs_to :gym
    belongs_to :client

    # validations
    validates :charge, presence: true
    validates :client_id, presence: true
    validates :gym_id, presence: true

    validate :check_client_validity
    validate :check_gym_validity
    validate :check_client_membership
    
    private

    def check_client_membership
        # a client have one membership per gym
        # when creating a membership:
        # check the client's id AGAINST their gyms
            # Membership.all returns an array
            # use Array.each to iterate
        client = Client.find_by(id: self.client_id)
        if(client)
            # assumption: client exists in database
            # check if self.gym_id === client.gyms.each(id)
            client.gyms.each do |gym_to_check|
                if(self.gym_id === gym_to_check.id)
                errors.add(:client_id, "client already belongs to a gym with this ID")
                end
            end            
        else
            errors.add(:client_id, "client not found")
        end
    end

    def check_client_validity
        # if client id is not in the database, throw an error
        if(!Client.find_by(id: self.client_id))
            errors.add(:client_id, "client not found")
        end
    end

    def check_gym_validity
        if(!Gym.find_by(id: self.gym_id))
            errors.add(:gym_id, "gym not found")
        end
    end

end
