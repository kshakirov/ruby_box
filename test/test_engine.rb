require 'rest-client'
require 'json'
require_relative '../lib/engine'
require "minitest/autorun"

class TestEngine < MiniTest::Test
  def setup
    @engine = Engine.new
    @request_body = {
        "arguments": [
            {
                "id": "123",
                "input": [
                    [
                        1,
                        2,
                        3
                    ]
                ],
                "converterIds": [
                    36
                ]
            }
        ]
    }
  end

  def test_main
    @engine.run @request_body
  end

  def test_request
     body  =RestClient.get 'http://54.148.156.110:4567/sync-module/converters/36'
     body = JSON.parse body, symbolize_names: true
    assert body
  end
end