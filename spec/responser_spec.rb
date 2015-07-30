require 'spec_helper'

describe Responser do
  context "request /time path without params" do
    let(:valid_request) { "GET /time HTTP/1.1\r\n" }
    let(:responser) { Responser.new(valid_request) }

    it "response with status 200" do
      response_status = responser.response.split(" ")[1]
      expect(response_status).to eq "200"
    end

    it "response with valid UTC time" do
      time = "UTC: " + Time.now.utc.strftime("%Y-%m-%d %H:%M:%S")
      expect(responser.response.scan(time).size).to eq 1
    end
  end

  context "request /time?Moscow" do
    let(:request_moscow_time) { "GET /time?Moscow HTTP/1.1\r\n" }
    let(:responser) { Responser.new(request_moscow_time) }

    it "response with status 200" do
      response_status = responser.response.split(" ")[1]
      expect(response_status).to eq "200"
    end

    it "response with valid UTC time" do
      time = "UTC: " + Time.now.utc.strftime("%Y-%m-%d %H:%M:%S")
      expect(responser.response.scan(time).size).to eq 1
    end

    it "response with valid Moscow time" do
      tz = Timezone::Zone.new zone: 'Europe/Moscow'
      time = "Moscow: " + tz.utc_to_local(Time.now.utc).strftime("%Y-%m-%d %H:%M:%S")
      expect(responser.response.scan(time).size).to eq 1
    end
  end

  context "request /time?Moscow,New%20York" do
    let(:request_cities_time) { "GET /time?Moscow,New%20York HTTP/1.1\r\n" }
    let(:responser) { Responser.new(request_cities_time) }

    it "response with status 200" do
      response_status = responser.response.split(" ")[1]
      expect(response_status).to eq "200"
    end

    it "response with valid UTC time" do
      time = "UTC: " + Time.now.utc.strftime("%Y-%m-%d %H:%M:%S")
      expect(responser.response.scan(time).size).to eq 1
    end

    it "response with valid Moscow time" do
      tz = Timezone::Zone.new zone: 'Europe/Moscow'
      time = "Moscow: " + tz.utc_to_local(Time.now.utc).strftime("%Y-%m-%d %H:%M:%S")
      expect(responser.response.scan(time).size).to eq 1
    end

    it "response with valid New York time" do
      tz = Timezone::Zone.new zone: 'America/New_York'
      time = "New York: " + tz.utc_to_local(Time.now.utc).strftime("%Y-%m-%d %H:%M:%S")
      expect(responser.response.scan(time).size).to eq 1
    end
    
  end

  context "requset invalid path" do
    let(:invalid_request) { "GET /invalid HTTP/1.1\r\n" }
    let(:responser) { Responser.new(invalid_request) }

    it "response with status 404" do
      response_status = responser.response.split(" ")[1]
      expect(response_status).to eq "404"
    end
  end
end
