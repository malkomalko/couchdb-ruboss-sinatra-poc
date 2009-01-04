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
  result = model.all.to_json
  
  puts "\n##############################"
  puts "ACTION: Index"
  puts "JSON: #{result}"
  puts "##############################\n\n"
    
  result
end

get '/:model/:id.json' do
  string = Inflector.camelize("#{params[:model]}")
  model  = Inflector.constantize(string)
  record = model.get(params[:id])
  result = record.to_json
  
  puts "\n##############################"
  puts "ACTION: Show"
  puts "JSON: #{result}"
  puts "##############################\n\n"
    
  result
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
  
  record = model.new(new_params)
  record.save
  result = record.to_json
  
  ############################################################
  # log both old/new params to console for your viewing
  ############################################################
  puts "\n##############################"
  puts "ACTION: Create"
  puts "JSON: #{result}"
  puts "OLD PARAMS: #{params.inspect}"
  puts "NEW PARAMS: #{new_params.inspect}"
  puts "##############################\n\n"
    
  result
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
  
  record.update_attributes(new_params)
  result = record.to_json
  
  ############################################################
  # log both old/new params to console for your viewing
  ############################################################
  puts "\n##############################"
  puts "ACTION: Update"
  puts "JSON: #{result}"
  puts "OLD PARAMS: #{params.inspect}"
  puts "NEW PARAMS: #{new_params.inspect}"
  puts "##############################\n\n"
    
  result
end

delete '/:model/:id.json' do
  string = Inflector.camelize("#{params[:model]}")
  model  = Inflector.constantize(string)
  record = model.get(params[:id])
  result = record.to_json
  record.destroy
  
  puts "\n##############################"
  puts "ACTION: Delete"
  puts "JSON: #{result}"
  puts "##############################\n\n"
  
  result
end