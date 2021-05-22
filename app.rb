require_relative "ganymede"
require_relative "router"

class App
  def call(env)
    puts env["REQUEST_METHOD"] + " " + env["PATH_INFO"]
    puts "User-Agent: " + env["HTTP_USER_AGENT"]
    puts

    # Rack specification response
    response_body = Router.new(env).dispatch
    [
      200,
      {
        'Content-Type' => 'text/html',
        'Content-Length' => response_body.size.to_s,
      },
      [response_body]
    ]
  end
end
