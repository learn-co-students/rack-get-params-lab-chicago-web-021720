require 'pry'
class Application

  @@cart = []
  @@items = ["Apples","Carrots","Pears"]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
        search_term = req.params["q"]
        resp.write handle_search(search_term)



        




    elsif req.path.match(/cart/) && @@cart.length > 0
      @@cart.each do |item|
        resp.write "#{item}\n"
    
      end
    elsif req.path.match(/cart/) && @@cart.length == 0 
      resp.write "Your cart is empty."


    elsif req.path.match(/add/)
      search_term = req.params
        search_term.each do |key, value|
          if @@items.include?(value)
          @@cart << value 
          resp.write "added #{value}"
        else
          resp.write "We don't have that item"
        end
      end
      #binding.pry





    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
