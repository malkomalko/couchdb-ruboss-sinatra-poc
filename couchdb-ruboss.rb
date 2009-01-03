############################################################
# require lib's
############################################################

require "rubygems"
require "sinatra"
# require "couchrest"

begin
  require 'thin'
rescue LoadError
  puts 'Lose a little weight maybe?'
end

# Dir["lib/*.rb"].each do |f|
#   require f
# end
# 
# Dir["models/*.rb"].each do |f|
#   require f
# end

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

# get '/:model.json' do
#   string = Inflector.camelize("#{params[:model]}")
#   model  = Inflector.constantize(string)
#   
#   model.all.to_json
# end
# 
# get '/:model/:id.json' do
#   string = Inflector.camelize("#{params[:model]}")
#   model  = Inflector.constantize(string)
#   record = model.get(params[:id])
#   record.to_json
# end
# 
# post '/:model.json' do
#   string = Inflector.camelize("#{params[:model]}")
#   model  = Inflector.constantize(string)
# 
#   new_params = {}
#   params.each do |k,v|
#     new_params["#{k.gsub(']','').
#       gsub(params['model']+'[','')}"] = v
#   end
#   
#   record = model.new(new_params)
#   record.save
#   record.to_json
# end
# 
# put '/:model/:id.json' do
#   string = Inflector.camelize("#{params[:model]}")
#   model  = Inflector.constantize(string)
# 
#   new_params = {}
#   params.each do |k,v|
#     new_params["#{k.gsub(']','').
#       gsub(params['model']+'[','')}"] = v
#   end
#   
#   record = model.get(params[:id])
#   record.update_attributes(new_params)
#   record.to_json
# end
# 
# delete '/:model/:id.json' do
#   string = Inflector.camelize("#{params[:model]}")
#   model  = Inflector.constantize(string)
#   
#   record = Note.get(params[:id])
#   
#   record.destroy.to_json
# end