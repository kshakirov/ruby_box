class Engine
  def initialize
    @converters = [
        {
            "id": 1,
            "name": "Multiplier",
            "language": "python",
            "code": "class Multiplier\n      def run batch\n        batch.map do |i|\n          puts i\n        end\n      end\n    end",
            "customAttributes": {
                "type": "Converter"
            }
        }
    ]
  end


  def converters ids
    ids.each {|i| puts i}
  end

  def process input, converter_names

    converter_names.map do |name|
      klass = Object.const_get "#{self.class.name}::#{name}"
      klass = klass.new
      klass.run input

    end
  end

  def run request_body
    converters request_body[:arguments][0][:converterIds]
    evaluate @converters
    process request_body[:arguments][0][:input], (@converters.map {|c| c[:name]})
  end

  def evaluate converters
    converters.each {|c| eval c[:code]}
  end


end