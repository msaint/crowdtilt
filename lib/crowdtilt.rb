require 'active_support'
require 'faraday'
require 'faraday_middleware'
require 'json'

class Crowdtilt

  attr_accessor :api_key, :api_secret, :mode
  
  def initialize(params)
    raise ArgumentError, "You must include both the api_key and api_secret" unless (params.include?(:api_key) && params.include?(:api_secret))
    @api_key = params[:api_key]
    @api_secret = params[:api_secret]
    
    if params[:mode] == 'production'
      @url = 'https://api.crowdtilt.com'
    else
      @url = 'https://api-sandbox.crowdtilt.com'
    end
    
  end
  
  def request(method,*args)
    conn = Faraday.new(:url => @url) do |faraday|
      # faraday.response :logger
      faraday.request :json
      faraday.response :json, :content_type => /\bjson$/
      faraday.use :instrumentation

      faraday.adapter Faraday.default_adapter
    end
    conn.basic_auth(@api_key, @api_secret)
    conn.headers.update({'Content-Type' => 'application/json'})
    
    res = conn.send method.to_sym, *args
      
    case res.status
      when 401
        raise "Invalid credentials"
      when 400...599
        if res.body.include? 'error'
          raise res.body['error']
        else
          raise 'Unknown error'
        end
      else
        res.body
    end
  end

  def get(string)
    request :get, uri(string)
  end

  def post(string, params={})
    request :post, uri(string), params
  end

  def put(string, params={})
    request :put, uri(string), params
  end

  def delete(string)
    request :delete, uri(string)
  end
  
  private
  
  def uri(string)   
    if string =~ /^\/v1/
      string
    elsif string =~ /^v1/
      '/' + string
    elsif string =~ /^\//
      '/v1' + string
    else
      '/v1/' + string
    end
  end

end