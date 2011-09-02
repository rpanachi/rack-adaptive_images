require 'rack/request'
require 'rack/response'

class Application

  def call(env)

    request = Rack::Request.new(env)
    response = Rack::Response.new

    if request.env["REQUEST_URI"] == "/"
      response.write "<title>Sample Application</title>"
      response.write "<h1>Adaptative Images Sample</h1>"
      response.write "<img src=\"/images/sample.jpg\"/>"
    elsif file = get_static_file(request)
      response.write file.to_s
    else
      response.write "NOT FOUND"
    end

    response.finish
  end

  def get_static_file(request)
    filepath = File.join(File.dirname(__FILE__), "public", request.env["REQUEST_URI"])
    File.open(filepath) if File.exists?(filepath)
  end
end
