require 'geocoder'
require 'redis'
require 'tzinfo'

class CitiesTime
  API_KEY = ENV['GOOGLE_API_KEY']

  Geocoder.configure(
    lookup: :google,
    api_key: API_KEY,
    use_https: true,
    cache: Redis.new)

  def initialize(cities, time)
    @cities = cities
    @time_now = time
  end

  def request_cities_time
    response = ""
    return response unless @cities
    @cities.each do |city|
      res = Geocoder.coordinates(city)

      uri = URI.parse("https://maps.googleapis.com/maps/api/timezone/json?"\
                      "location=#{res[0]},#{res[1]}"\
                      "&timestamp=#{@time_now.to_i}"\
                      "&key=#{API_KEY}")
      data = JSON.parse(Net::HTTP.get(uri))
      tz = TZInfo::Timezone.get(data['timeZoneId'])
      time = tz.utc_to_local(@time_now).strftime("%Y-%m-%d %H:%M:%S")

      response << "#{city}: #{time}\r\n"
    end
    response
  end
end
