require_relative "ganymede"

class App
  def call(env)
    puts env["REQUEST_METHOD"] + " " + env["PATH_INFO"]
    puts "User-Agent: " + env["HTTP_USER_AGENT"]
    puts

    # Rack specification response
    message = "Body for PID #{Process.pid}.\n"
    [
      200,
      {
        'Content-Type' => 'text/plain',
        'Content-Length' => message.size.to_s
      },
      [message]
    ]
  end
end
