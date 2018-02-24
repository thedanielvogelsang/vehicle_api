class MakeSerializer < ActiveModel::Serializer
  cache
  delegate :cache_key, :to => :object
  attributes :id, :company, :company_desc, :company_motto, :ceo_statement
end
