class MembershipSerializer < ActiveModel::Serializer
  attributes :id, :gym_id, :client_id, :charge
end
