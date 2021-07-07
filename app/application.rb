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
    
    elsif req.path.match(/cart/)
      if @@cart.empty?
        resp.write "Your cart is empty"
      else
        @@cart.each do |cart|
          resp.write "#{cart}\n"
        end
      end
    
    elsif req.path.match(/add/)
      resp.write handle_search(req.params['item'])


      # if @@items.include?(search_term)
      #   @@cart << search_term
      # else
      #   resp.write "We don't have that item"
      # end
    
    else
      resp.write "Path Not Found"
    end
    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      @@cart << search_term
      return "added #{search_term}"
    else
      #return "Couldn't find #{search_term}"
      return "We don't have that item"
    end
  end
end
