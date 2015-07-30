require 'socket'
require_relative 'responser'

Thread.abort_on_exception = true

server = TCPServer.open('127.0.0.1', 2000)
loop do
  Thread.start(server.accept) do |client|
    request_string = client.gets
    STDERR.puts request_string
    responser = Responser.new(request_string)
    client.print responser.response
    client.close
  end
end
