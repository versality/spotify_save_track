# frozen_string_literal: true

class HTTPServer
  def call
    session = server.accept
    request = session.gets

    _method, path, _protocol = request.split

    status, _headers, _body = app.call
    session.print response_status(status)

    session.close

    parse_request(path)
  end

  def app
    -> { ['200', {}, []] }
  end

  def server
    TCPServer.new 8888
  end

  def parse_request(path)
    CGI.parse(path)
  end

  def response_status(status)
    "HTTP/1.1 #{status}\r\n"
  end
end
