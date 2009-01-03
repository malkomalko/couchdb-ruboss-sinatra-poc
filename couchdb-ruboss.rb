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

Dir["lib/*.rb"].each do |f|
  require f
end

require "models/couch_model"

############################################################
# setup
############################################################

mime :json, "application/json"

error do  
  puts "\n##############################"
  puts "Sorry there was a nasty error:"
  puts request.env['sinatra.error']
  puts "##############################\n"
end

############################################################
# routes
############################################################

get '' do
  Sinatra.env.to_s == 'development' ? (erb :local) : (erb :production)
end

get '/' do
  Sinatra.env.to_s == 'development' ? (erb :local) : (erb :production)
end

get '/:model.json' do
  string = Inflector.camelize("#{params[:model]}")
  model  = Inflector.constantize(string)
  model.all.to_json
end

get '/:model/:id.json' do
  string = Inflector.camelize("#{params[:model]}")
  model  = Inflector.constantize(string)
  record = model.get(params[:id])
  record.to_json
end

post '/:model.json' do
  string = Inflector.camelize("#{params[:model]}")
  model  = Inflector.constantize(string)

  ############################################################
  # strips the surrounding model[ ] off params
  ############################################################
  new_params = {}
  params.each do |k,v|
    new_params["#{k.gsub(']','').
      gsub(params['model']+'[','')}"] = v
  end
  
  ############################################################
  # save model based off newly formatted params hash
  ############################################################
  record = model.new(new_params)
  record.save
  record.to_json
end

put '/:model/:id.json' do
  string = Inflector.camelize("#{params[:model]}")
  model  = Inflector.constantize(string)
  record = model.get(params[:id])
  
  ############################################################
  # also strips out the _method param, we don't want that
  ############################################################
  new_params = {}
  params.each do |k,v|
    unless k.to_s == '_method'
      new_params["#{k.gsub(']','').
        gsub(params['model']+'[','').gsub('id','_id').
        gsub('__id', '_id')}"] = v
    end
  end
  
  ############################################################
  # log both old/new params to console for your viewing
  ############################################################
  puts "\n____PARAMS TO CONSOLE____\n
    OLD PARAMS: #{params.inspect}\n
    NEW PARAMS: #{new_params.inspect}\n\n"
    
  record.update_attributes(new_params)
  record.to_json
end

delete '/:model/:id.json' do
  string = Inflector.camelize("#{params[:model]}")
  model  = Inflector.constantize(string)
  record = model.get(params[:id])
  
  ############################################################
  # log both old/new params to console for your viewing
  ############################################################
  puts "____PARAMS TO CONSOLE____\n
    PARAMS: #{params.inspect}\n\n"
    
  record.destroy
  redirect "/#{params[:model]}.json"
end