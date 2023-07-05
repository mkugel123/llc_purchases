class PropertySerializer < ActiveModel::Serializer
  attributes :id, :document_id, :owner_address_1, :owner_address_2, :owner, :property_street_name, :property_street_number, :date_on_deed, :doc_amount
end
