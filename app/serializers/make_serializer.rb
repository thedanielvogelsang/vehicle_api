class MakeSerializer < ActiveModel::Serializer
  cache
  delegate :cache_key, :to => :object
  attributes :company, :id, :company_desc, :company_motto, :ceo_statement
end
