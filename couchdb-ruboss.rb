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

get '' do
  Sinatra.env.to_s == 'development' ? (erb :local) : (erb :production)
end

get '/' do
  Sinatra.env.to_s == 'development' ? (erb :local) : (erb :production)
end

####
# passing in arbitrary data to flex, kind've like to_fxml
get '/server_settings.json' do
  { "_id" => "1", "_rev" => "1", "ruby_class" => "ServerSetting",
    "environment" => Sinatra.env.to_s }.to_json
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
