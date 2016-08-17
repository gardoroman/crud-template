# Select all user records
get '/users' do
  @users = User.all
  erb :'users/index'
end

get '/users/login' do
  @user = User.new
  erb :'users/login'
end

# Directs to form for creating a new user record
get '/users/new' do
  @user = User.new
  erb :'users/new'
end

# Select a specific user record
get '/users/:id' do
  #-- authorize depending on business rules --#
  authorize!
  @user = current_user

  #This may be unnecessary depending on business rules
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
    @user = User.new
    @errors = user.errors.full_messages
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
    @user = User.new
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
  #   authorize!
  # @user = User.find(params[:id])
  # @user.update(params[:user])
  # redirect '/users/#{@user.id}'
end

# Deletes a user record
delete '/users/:id' do
  # authorize!
  # User.find(params[:id]).destroy
  # redirect '/'
end
