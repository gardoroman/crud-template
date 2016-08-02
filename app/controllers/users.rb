# Select all user records
get '/users' do

end

get '/users/login' do
  erb :'users/login'
end


# Directs to form for creating a new user record
get '/users/new' do
  @user = User.new
  erb :'users/new'
end

# Select a specific user record
get '/users/:id' do
  authorize!
  @user = current_user
  if @user.id.to_s == params[:id]
    erb :'users/show'
  else
    @errors = ["Please log in to access your content"]
    erb :'users/login'
  end
end

# Directs to form for editing a specific user record
get '/users/:id/edit' do

end

# insert a new user record
post '/users' do
  user = User.new(params[:user])
  if user.save
    session[:user_id] = user.id
    redirect "/users/#{user.id}"
  else
    @errors = user.errors.full_messages
    # When building out redirect to appropriate erb
    # @model = Model.most_recent
    erb :'users/new'
  end


end

# Post action to log in user
post '/users/login' do
  @user = User.find_by_email(params[:user][:email])
  if @user &&  @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
  else
    @errors = ["Log-in was invalid"]
    erb :'users/login'
  end
end

post '/users/logout' do
  session[:user_id] = nil
  #erb :'index'
  redirect '/'
end

# Updates a user record
put '/users/:id' do

end

# Deletes a user record
delete '/users/:id' do

end
