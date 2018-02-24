class ModelSerializer < ActiveModel::Serializer
  attributes :id, :name, :make

  def make
    object.make.company
  end

end
