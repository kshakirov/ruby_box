require_relative '../scripts/attributes_transpose'
require_relative 'data/attributes_transpose_input'
require "minitest/autorun"

class TestAttributeTranspose < MiniTest::Test
  def setup
    @transposer = AttributeTranspose.new
    @data = {
        "arguments": [
            {
                "id": "111122",
                "input": [
                    [
                        {"Internal_Reference": "DC-DAC5001", "color_attribute": "DAC5001", "is_active": "product", "primary_key": "Internal_Reference"},
                        {"Internal_Reference": "DC-ACS8014", "color_attribute": "ACS8014", "is_active": "product", "primary_key": "Internal_Reference"},
                        {"Internal_Reference": "DC-HTA3010", "color_attribute": "HTA3010", "is_active": "product", "primary_key": "Internal_Reference"}
                    ]
                ],
                "converterIds": [
                    36
                ]
            },
            {
                "id": "125",
                "input": [
                    [
                        3,
                        100,
                        23
                    ]
                ],
                "converterIds": [
                    36
                ]
            }
        ]
    }
  end

  def test_run
    result  =@transposer.run @data[:arguments][0][:input][0]
    assert result
  end
end