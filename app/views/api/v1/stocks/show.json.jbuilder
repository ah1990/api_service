json.stock do
  json.extract! @stock, :id, :name
  json.bearer do
    json.extract! @stock.bearer, :id, :name
  end
end