require_relative 'cities_time'

class Responser
  PATH = '/time'

  STATUS_MESSAGES = {
    200 => '200 OK',
    404 => '404 Not Found'
  }

  def initialize(request)
    @request = request
    @time_now = Time.now.utc
  end

  def parse_request
    return unless @request
    request_params = @request.split(" ")[1]
    path, raw_params = request_params.split("?")
    params = CGI.unescape(raw_params).split(",") if raw_params
    [path, params]
  end

  def response
    request_path, cities = parse_request
    message = "Path not found\n"
    status = 404

    if request_path == PATH
      message = "UTC: " + @time_now.strftime("%Y-%m-%d %H:%M:%S") + "\r\n"
      cities_time = CitiesTime.new(cities, @time_now)
      message << cities_time.request_cities_time
      status = 200
    end

    "HTTP/1.1 #{STATUS_MESSAGES[status]}\r\n"\
    "Content-Type: text/plain\r\n"\
    "Content-Length: #{message.size}\r\n"\
    "Connection: close\r\n"\
    "\r\n"\
    "#{message}"
  end
end
