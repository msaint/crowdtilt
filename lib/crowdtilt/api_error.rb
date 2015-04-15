module Crowdtilt

  class ApiError < StandardError
    attr_accessor :response, :error_id

    def initialize(message, response)
      @response = response
      begin
        @error_id = response[:body]['error_id']
      rescue
        # eat it
      end
      super(message)
    end
  end
end