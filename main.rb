require_relative "ganymede"
require_relative "app"

server = Ganymede.new(9292, App.new)
server.serve
