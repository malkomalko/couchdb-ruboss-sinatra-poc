class CouchModel < CouchRest::Model
  
  ############################################################
  # setup
  ############################################################
  
  CouchUrl = "http://127.0.0.1:5984/sinatra"
  self.use_database(CouchRest.database!(CouchUrl))
  
  ############################################################
  # attributes
  ############################################################
  
  key_accessor :_id, :model
  timestamps!
  
end