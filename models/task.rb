class Task < CouchModel
  key_accessor :name, :notes, :start_date, :end_date, :completed, :next_action
  key_accessor :project_id, :location_id, :user_id
end