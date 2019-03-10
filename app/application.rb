class Application
  @@items = [Item.new("Apples",5.23), Item.new("Oranges",2.43)]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    # application should only accept /items/<ITEM NAME> route
    if req.path.match(/items/)
      wanted_item_name = req.path.split("/items/").last
      # if user requests /items/<Item Name>, return price of item
      if item = @@items.find {|i| i.name == wanted_item_name}
        resp.write item.price
      # if user requests an item you don't have, return 400
      else
        resp.write "Item not found"
        resp.status = 400
      end
    # any route other than /items/<ITEM NAME> should be 404
    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end
end
