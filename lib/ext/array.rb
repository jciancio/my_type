class Array
  def to_data_collection
    DataCollection.new(self)
  end
end
