class ModelSerializer < ActiveModel::Serializer
  attributes :id, :name, :manufacturer

  def manufacturer
    object.make.company
  end

end
