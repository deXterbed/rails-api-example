module ApiHelpers
  def json_data
    json[:data]
  end

  def  json
    JSON.parse(response.body).deep_symbolize_keys
  end
end