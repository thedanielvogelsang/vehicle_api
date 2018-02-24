class ModelSerializer < ActiveModel::Serializer
  attributes :name, :manufacturer, :id,

  def manufacturer
    object.make.company
  end

end
