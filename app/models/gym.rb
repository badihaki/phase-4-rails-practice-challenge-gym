class Gym < ApplicationRecord
    # associations
    has_many :memberships, dependent: :destroy
    has_many :clients, through: :memberships

    # validations
end
