require 'rack/request'
require 'rack/response'
require 'mime/types'

class Application

  def initialize
    @root = File.expand_path(File.dirname(__FILE__))
  end

  def call(env)

    request = Rack::Request.new(env)
    response = Rack::Response.new
    path = Rack::Utils.unescape(env['REQUEST_PATH'])

    #index
    if path == "/"
      response.write "<title>Sample Application</title>"
      response.write "<h1>Adaptative Images Sample</h1>"
      response.write "<img src=\"/images/sample.jpg\"/>"
      response.finish

    #static
    elsif File.exists?(filename = File.join(@root, "public", path))
      [200, {"Content-Type" => MIME::Types.of(filename).to_s}, File.read(filename)]

    #not found
    else
      response.write "404"
      response.finish
    end

  end

end
