json.array!(@records) do |record|
  json.extract! record, :id, :klass, :value
  json.url record_url(record, format: :json)
end
