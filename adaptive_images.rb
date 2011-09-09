class AdaptiveImages

  IMAGE_MIME_TYPES = %w(image/jpeg image/png image/gif)

  def initialize(app, options = {})
    @app = app
    @mime_types = options.delete(:mime_types) || IMAGE_MIME_TYPES
  end
  
  def call(env)
    status, headers, response = @app.call(env)

    if @mime_types.include? headers['Content-Type']
     
      puts "Adaptive Images was touched! Environment: #{env.inspect}"

      #TODO get the root dir from the application
      root = File.expand_path(File.dirname(__FILE__))

      user_agent = env["HTTP_USER_AGENT"]
      request_path = Rack::Utils.unescape(env['REQUEST_PATH'])

      #TODO define a strategy to process images for each user_agent
      if user_agent.match /Mozilla|WebKit/

        #send the original image
        image_path = File.join(root, "public", request_path)

     elsif user_agent.match /iPhone|Android/

        #send a pre-processed and smaller image
        #for example, append '-small' to the filename
        image_path = File.join(root, "public", request_path)
        extension = File.extname(image_path)
        image_path = image_path.gsub(extension, "-small" + extension)

      end

      #send the response!
      response = Rack::Response.new
      response.write File.read(image_path)
      response.finish

    end

    [status, headers, response]
  end

end
