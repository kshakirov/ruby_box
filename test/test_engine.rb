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
                    1
                ]
            }
        ]
    }
  end

  def test_main
    @engine.run @request_body
  end
end