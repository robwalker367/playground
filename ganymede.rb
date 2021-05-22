require "socket"
require "http/parser"
require "thread"

class Ganymede
  def initialize(port, app)
    @server = TCPServer.new(port)
    @app = app
  end

  def serve
    prefork
  end

  private

  attr_accessor :server, :app

  TOTAL_FORKS = 3

  def prefork
    puts "Main PID: #{Process.pid}"
    TOTAL_FORKS.times do
      fork do
        puts "Forked PID: #{Process.pid}"
        start
      end
    end
    Process.waitall
  end

  def start
    loop do
      socket = server.accept
      connection = Connection.new(socket, app)
      connection.process
    end
  end
end

class Connection
  def initialize(socket, app)
    @socket = socket
    @parser = Http::Parser.new(self)
    @app = app
  end

  HTTP_STATUS_CODES = {
    200 => "OK",
    404 => "Not Found",
  }

  def process
    until socket.closed? || socket.eof?
      data = socket.readpartial(1024)
      parser << data
    end
    on_message_complete
  end

  private

  attr_accessor :socket, :parser, :app

  def on_message_complete
    env = {
      "REQUEST_METHOD" => parser.http_method,
      "PATH_INFO" => parser.request_url,
    }

    parser.headers.each do |name, value|
      env["HTTP_" + name.upcase.tr("-", "_")] = value
    end

    send_response(env)
  end

  def send_response(env)
    status, headers, body = app.call(env)
    reason = HTTP_STATUS_CODES[status]

    socket.write("HTTP/1.1 #{status} #{reason}\r\n")

    headers.each do |name, value|
      socket.write("#{name}, #{value}\r\n")
    end

    socket.write("\r\n")

    body.each do |chunk|
      socket.write(hunk)
    end
    
    socket.close
  end
end
