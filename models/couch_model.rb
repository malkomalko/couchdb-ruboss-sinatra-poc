class CouchModel < CouchRest::Model
  
  ############################################################
  # setup
  ############################################################
  
  %w(project task todo).each do |model|
    require File.dirname(__FILE__) + "/#{model}"
  end
  
  CouchUrl = "http://127.0.0.1:5984/sinatra"
  self.use_database(CouchRest.database!(CouchUrl))
  
  ############################################################
  # attributes
  ############################################################
  
  timestamps!
  
end