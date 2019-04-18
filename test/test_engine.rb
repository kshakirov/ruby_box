require 'rest-client'
require 'json'
require_relative '../lib/engine'
require 'minitest/autorun'

class TestEngine < MiniTest::Test
  def setup
    @engine = Engine.new
    @request_body = {
        "arguments": [
            {
                "id": '123',
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
    response = @engine.run @request_body
    assert response
  end

  def get_converter id
    body = RestClient.get "http://54.148.156.110:4567/sync-module/converters/#{id}"
    JSON.parse body, symbolize_names: true
  end

  def test_request
    assert get_converter 36
  end

  def test_t_request
    body = get_converter(36)
    request_body = {
        "arguments":
            [
                1,
                2,
                3
            ],

        "converter": {
            "name": "Multiplier",
            "code": body[:code]
        }
    }
    response = @engine.test request_body
    assert response.key? :status
  end
end
