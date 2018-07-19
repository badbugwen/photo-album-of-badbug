json.data do
  json.array! @photos do |photo|
    json.(photo, :id, :title, :description, :file_location)
  end
end