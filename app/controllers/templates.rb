# Select all MODEL records
get '/MODELS' do

end

# Directs to form for creating a new MODEL record
get '/MODELS/new' do
  authorize!

end

# Select a specific MODEL record
get '/MODELS/:id' do

end

# Directs to form for editing a specific MODEL record
get '/MODELS/:id/edit' do
  authorize!
  #validate user ownership of model
end

# insert a new MODEL record
post '/MODELS' do
  authorize!

end

# Updates a MODEL record
put '/MODELS/:id' do
  authorize!
  #validate user ownership of model


end

# Deletes a MODEL record
delete '/MODELS/:id' do
  authorize!
  #validate user ownership of model

end
