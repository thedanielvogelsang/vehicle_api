class MakeSerializer < ActiveModel::Serializer
  attributes :id, :company, :company_desc, :company_motto, :ceo_statement
end
