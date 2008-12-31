############################################################
# require lib's
############################################################

require "rubygems"
require "sinatra"
require "couchrest"

begin
  require 'thin'
rescue LoadError
  puts 'Lose a little weight maybe?'
end

require File.dirname(__FILE__) + "/lib/inflector"
require File.dirname(__FILE__) + "/models/couch_model"

############################################################
# setup
############################################################

mime :json, "application/json"

############################################################
# routes
############################################################

get '/' do
  erb :index
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
    new_params["#{k.gsub(']','').
      gsub(params['model']+'[','')}"] = v
  end
  
  record = model.new(new_params)
  record.save
  record.to_json
end
