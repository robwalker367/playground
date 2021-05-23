require_relative "ganymede"
require_relative "router"

class App
  ALLOWED_HTTP_METHODS = ["GET"]

  def call(env)
    puts env["REQUEST_METHOD"] + " " + env["PATH_INFO"]
    puts "User-Agent: " + env["HTTP_USER_AGENT"]
    puts

    # Rack specification response
    if ALLOWED_HTTP_METHODS.include?(env["REQUEST_METHOD"])
      response_body = Router.new(env).dispatch
      [
        200,
        {
          'Content-Type' => 'text/html',
          'Content-Length' => response_body.size.to_s,
        },
        [response_body]
      ]
    else
      [405, {}, ["Method not allowed: #{method}"]]
    end
  end
end
