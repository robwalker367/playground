require_relative "ganymede"

class App
  def call(env)
    puts env["REQUEST_METHOD"] + " " + env["PATH_INFO"]
    puts "User-Agent: " + env["HTTP_USER_AGENT"]
    puts

    sleep(5) if env["PATH_INFO"] == "/sleep"

    message = "Hello from the tube #{Process.pid}.\n"
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

server = Ganymede.new(9292, App.new)
server.serve
