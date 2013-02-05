class JqueryAutocomplete

  def self.array_of_clickable(label_array, value_array)
     (label_array.zip value_array).map {|k, v| {:label=>k, :value=>v} }
  end

end