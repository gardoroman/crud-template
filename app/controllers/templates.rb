# Select all MODEL records
get '/MODELs' do
  @model = MODEL.all
  erb :'/MODELs/index'
end

# insert a new MODEL record
post '/MODELs' do
  authorize!
  @model = MODEL.new(params[:model])

  if @model.save
    redirect "/MODELs/#{@model.id}"
  else
    @errors = @model.errors.full_messages
    erb :'/MODELs/show'
  end
end

# Directs to form for creating a new MODEL record
get '/MODELs/new' do
  authorize!
  erb :"/MODELs/new"
end

before '/MODELs/:id' do
  pass if request.path_info.match /new/
  @model = find_and_ensure_MODEL(params[:id])
end


# Select a specific MODEL record
get '/MODELs/:id' do
  @model = MODEL.find(params[:id])
  if @model
    erb :"/MODELs/show"
  else
    erb :"404.erb"
  end
end

# Directs to form for editing a specific MODEL record
get '/MODELs/:id/edit' do
  @model = MODEL.find(params[:id])
  if logged_in? and @model.USER_ID == current_user.id
    erb :'/MODELs/edit'
  else
    @model = MODEL.all
    @errors = ['You are not authorized to edit this content']
    erb :'/MODELs/index'
  end
end

# Updates a MODEL record
put '/MODELs/:id' do
  @model = MODEL.find(params[:id])
  if logged_in? and @model.USER_ID == current_user.id
  @model.update(params[:model])
  if @model.save
    redirect "/models/#{@model.id}"
  else
    @errors = @model.errors.full_messages
    erb :'/MODELs/edit'
  end
end


end

# Deletes a MODEL record
delete '/MODELs/:id' do
  authorize!
  #validate user ownership of model

end
