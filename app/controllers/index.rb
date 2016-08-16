get '/' do
  @user = current_user || User.new
  erb :index
end
