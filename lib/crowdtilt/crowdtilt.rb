require 'active_support'
require 'faraday'
require 'faraday_middleware'
require 'json'

module Crowdtilt

  class << self

    attr_accessor :api_key, :api_secret, :mode, :base_url, :version

    def configure(params)
      raise ArgumentError, "You must include both the api_key and api_secret" unless (params.include?(:api_key) && params.include?(:api_secret))
      @api_key = params[:api_key]
      @api_secret = params[:api_secret]

      @version = 'v1'

      if params[:mode] == 'production'
        @mode = 'production'
        @base_url = 'https://api.crowdtilt.com'
      else
        @mode = 'sandbox'
        @base_url = 'https://api-sandbox.crowdtilt.com'
      end

      @base_url = params[:base_url] if params[:base_url]
      @version = params[:version] if params[:version]

      true
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

    def get_users()
      get("/users")['users']
    end

    def get_user(id)
      get("/users/#{id}")['user']
    end

    def create_user(user)
      post("/users", { :user => user })['user']
    end

    def update_user(id, user)
      put("/users/#{id}", { :user => user })['user']
    end

    private

    def request(method,*args)
      conn = Faraday.new(:url => @base_url) do |faraday|
        # faraday.response :logger
        faraday.request :json
        faraday.response :json, :content_type => /\bjson$/
        faraday.use :instrumentation
        faraday.adapter Faraday.default_adapter
      end
      conn.basic_auth(@api_key, @api_secret)
      conn.headers.update({'Content-Type' => 'application/json'})

      res = conn.send method.to_sym, *args
      handle_response(res)
    end

    def handle_response(res)
      response_obj = res.respond_to?(:to_hash) ? res.to_hash : res
      case response_obj[:status]
        when 401
          raise ApiError.new('Invalid credentials', response_obj)
        when 400...599
          if response_obj[:body].include? 'error'
            raise ApiError.new(response_obj[:body]['error'], response_obj)
          else
            raise ApiError.new('Unknown error', response_obj)
          end
        else
          response_obj[:body]
      end
    end

    def uri(string)
      if string =~ /^\/v/
        string
      elsif string =~ /^v/
        '/' + string
      elsif string =~ /^\//
        "/#{@version}" + string
      else
        "/#{@version}/" + string
      end
    end

  end

end
