#Simple Ruby Time Webserver

There is just simple webserver that response with requested city time.
Before you can start you need to register your [Geoname](http://www.geonames.org/). It's free and simple.

## Getting started
* Register your [Geoname](http://www.geonames.org/) and [activate it](http://www.geonames.org/manageaccount)
* Set Environment Variable GEONAME 
  `export GEONAME=your_geoname`
* Install necessary gem's
  `bundle install`
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
