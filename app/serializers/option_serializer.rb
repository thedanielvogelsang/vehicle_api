class OptionSerializer < ActiveModel::Serializer
  cache
  delegate :cache_key, :to => :object
  attributes :id, :name, :description, :unit_price, :promotion_code, :available_for

  def unit_price
    ('%.2f' % (object.price.to_f)).insert(0, '$')
  end

  def available_for
    object.model.make.company + ', ' + object.model.name
  end
end
