#Simple Ruby Time Webserver

There is just simple webserver that response with requested city time.
Before you can start you need to get your [google api key](https://console.developers.google.com). It's free and simple.

## Getting started
* Register your [google api key](https://console.developers.google.com)
* [Activate geolocation API](https://developers.google.com/maps/documentation/geolocation/intro?hl=en_US)
* [Activate timezone API](https://developers.google.com/maps/documentation/timezone/intro?hl=en_US)
* Set Environment Variable GOOGLE_API_KEY
  `export GOOGLE_API_KEY=your_google_api_key`
* Install necessary gem's
  `bundle install`
* [Install Redis](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-redis)
* Run server
  `ruby server.rb`

## Example requests and response from server
```
http://localhost:2000/time

UTC: 2015-04-11 10:30:50

http://localhost:2000/time?Moscow,New York

UTC: 2015-04-11 10:30:50
Moscow: 2015-04-11 13:30:50
New York: 2015-04-11 02:30:50
```

## TODO
```
* Add cashing for lookup timezone
```