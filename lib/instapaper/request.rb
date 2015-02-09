module Instapaper
  # Defines HTTP request methods
  module Request
    # Perform an HTTP POST request
    def post(path, options = {}, raw = false)
      request(:post, path, options, raw)
    end

    private

    # Perform an HTTP request
    def request(method, path, options, raw = false)
      response = connection(raw).send(method) do |request|
        request.path = path_prefix + path
        request.body = options unless options.empty?
      end
      raw ? response : response.body
    end
  end
end
