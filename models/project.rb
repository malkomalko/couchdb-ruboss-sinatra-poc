class Project < CouchModel
  key_accessor :name, :notes, :start_date, :end_date, :completed
  key_accessor :user_id
end