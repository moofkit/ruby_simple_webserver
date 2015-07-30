require 'timezone'
require 'geokit'
require 'cgi'

class Responser
  PATH = '/time'

  STATUS_MESSAGES = {
    200 => '200 OK',
    404 => '404 Not Found'
  }

  Timezone::Configure.begin do |c|
    c.username = ENV['GEONAME']
  end

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

  def cities_time(cities)
    response = ""
    return response unless cities
    cities.each do |city|
      res = Geokit::Geocoders::GoogleGeocoder.geocode(city)
      timezone = Timezone::Zone.new(latlon: res.to_a)
      time = timezone.time(@time_now).strftime("%Y-%m-%d %H:%M:%S")
      response << "#{city}: #{time}\r\n"
    end
    response
  end

  def response
    request_path, cities = parse_request
    message = "Path not found\n"
    status = 404

    if request_path == PATH
      message = "UTC: " + @time_now.strftime("%Y-%m-%d %H:%M:%S") + "\r\n"
      message << cities_time(cities)
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
