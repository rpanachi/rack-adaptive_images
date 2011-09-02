class AdaptiveImages

  def initialize(app)
    @app = app
  end
  
  def call(env)
    puts "AdaptiveImages middleware..."
    @app.call(env)
  end

end
