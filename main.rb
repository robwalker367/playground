require_relative "ganymede"
require_relative "app"

server = Ganymede.new(3000, App.new)
server.serve
