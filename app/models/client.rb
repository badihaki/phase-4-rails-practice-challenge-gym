class Client < ApplicationRecord
    # associations
    has_many :memberships
    has_many :gyms, through: :memberships

    # validations
    # none :P

    # custom methods
    def comnined_membership_cost
        total = self.memberships.reduce(0) {|running_total, individual_membership| running_total + individual_membership.charge}
        total
    end
end
