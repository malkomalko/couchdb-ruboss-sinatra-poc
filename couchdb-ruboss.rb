require "rubygems"
require "sinatra"
require "couchrest"

begin
  require 'thin'
rescue LoadError
  puts 'Lose a little weight maybe?'
end

require File.dirname(__FILE__) + "/lib/inflector"

############################################################
# models (couchrest)
############################################################

class Project < CouchRest::Model
  key_accessor :title, :body
  timestamps!
end

class Task < CouchRest::Model
  key_accessor :name
  timestamps!
end

############################################################
# setup
############################################################

mime :json, "application/json"

configure do
  CouchUrl = "http://localhost:5984/sinatra"
  [Project, Task].each do |model|
    model.use_database(CouchRest.database!(CouchUrl))
  end
end

############################################################
# routes
############################################################

get '/' do
  redirect '/Couch.html'
end

get '/:model.json' do
  string = Inflector.camelize("#{params[:model]}")
  model  = Inflector.constantize(string)
  
  model.all.to_json
end

post '/:model.json' do
  string = Inflector.camelize("#{params[:model]}")
  model  = Inflector.constantize(string)

  new_params = {}
  params.each do |k,v|
    new_params["#{k.gsub(']','').gsub(params['model']+'[','')}"] = v
  end
  
  record = model.new(new_params)
  record.save
  record.to_json
end