class Engine
  def initialize
    #TODO must be provided from config
    @url = 'http://54.148.156.110:4567/sync-module/converters'
  end

  def converters ids
    ids.map do |i|
      body = RestClient.get "#{@url}/#{i}"
      JSON.parse body, symbolize_names: true
    end
  end

  def process input, converters_names, request_id
    converters_names.map do |name|
      klass = Object.const_get "#{self.class.name}::#{name}"
      klass = klass.new
      value = nil
      rejected = false
      status = 200
      begin
        value = klass.run input
      rescue StandardError => e
        status = 500
        rejected = true
      end
      {
          id: request_id,
          status: status,
          value: value,
          rejected: rejected
      }

    end
  end

  def run request_body
    args = request_body[:arguments].map do |r|
      convs = converters r[:converterIds]
      evaluate convs
      process r[:input], (convs.map {|c| c[:name]}),
              r[:id]
    end
    {
        results: args.flatten
    }

  end

  def evaluate converters
    converters.each {|c| eval c[:code]}
  end


end