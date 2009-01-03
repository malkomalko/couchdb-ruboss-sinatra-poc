class Task < CouchModel
  key_accessor :name, :notes, :start_date, :end_date, :completed, :next_action
end