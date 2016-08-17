module ContentControllerHelper
  def find_and_ensure_MODEL(id)
    post = Restaurant.find_by(id: id)
    halt(404, erb(:'404')) if post.nil?
    post
  end
end

helpers ContentControllerHelper
