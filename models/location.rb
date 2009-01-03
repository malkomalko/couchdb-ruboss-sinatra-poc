class Location < CouchModel
  key_accessor :name, :notes
  key_accessor :user_id
end