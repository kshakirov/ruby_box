class AttributeTranspose

  def itemize item, rows, p_k_name, p_k_value
    rows.map do |r|
      i = {}
      i[p_k_name] = p_k_value
      i['Attribute Name'] = r
      i['Attribute Value'] = item[r]
      i
    end
  end

  def trans item
    p_k_name = item[:primary_key]
    p_k_value = item[p_k_name.to_sym]
    rows = item.keys.
        select {|k| not (k == p_k_name.to_sym or k == :primary_key)}
    itemize item, rows, p_k_name, p_k_value
  end

  def run arguments
    batches = arguments.first.map {|item| trans item}
    batches.flatten
  end
end