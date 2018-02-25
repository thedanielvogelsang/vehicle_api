class ModelSerializer < ActiveModel::Serializer
  attributes :name, :manufacturer, :id, :year

  def manufacturer
    object.make.company
  end

  def year
    object.year.year
  end

end
