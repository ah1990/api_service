json.stocks @stocks do |stock|
  json.extract! stock, :id, :name
  json.bearer do
    json.extract! stock.bearer, :id, :name
  end
end