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
    @url = 'http://54.148.156.110:4567/sync-module/converters'
  end


  def converters ids
    ids.map do |i|
      body = RestClient.get "#{@url}/#{i}"
      JSON.parse body, symbolize_names: true
    end
  end

  def process input, converter_names

    converter_names.map do |name|
      klass = Object.const_get "#{self.class.name}::#{name}"
      klass = klass.new
      klass.run input

    end
  end

  def run request_body
    convs = converters request_body[:arguments][0][:converterIds]
    evaluate convs
    process request_body[:arguments][0][:input], (@converters.map {|c| c[:name]})
  end

  def evaluate converters
    converters.each {|c| eval c[:code]}
  end


end