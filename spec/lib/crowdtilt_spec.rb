require 'spec_helper'

describe "Configuring" do

  it "should raise exception if api creds are missing" do
    expect {
      Crowdtilt.configure
    }.to raise_error(ArgumentError)
  end

  it "should raise exception if api creds are incomplete" do
    expect {
      Crowdtilt.configure :api_key => "hello"
    }.to raise_error(ArgumentError)
  end

  it "should pass if api creds are complete" do
    Crowdtilt.configure :api_key => "key", :api_secret => "secret"
    Crowdtilt.api_key.should == "key"
    Crowdtilt.api_secret.should == "secret"
    Crowdtilt.mode.should == "sandbox"
    Crowdtilt.base_url.should == "https://api-sandbox.crowdtilt.com"
  end

  it "should hit production if mode is set to production" do
    Crowdtilt.configure :api_key => "key", :api_secret => "secret", :mode => "production"
    Crowdtilt.api_key.should == "key"
    Crowdtilt.api_secret.should == "secret"
    Crowdtilt.mode.should == "production"
    Crowdtilt.base_url.should == "https://api.crowdtilt.com"
  end

  it 'should return body for 200 status code' do
    fake_env_200 = {
        :status => 200,
        :body => 'a request body'
    }
    response_200 = Faraday::Response.new(fake_env_200)

    Crowdtilt.module_exec(response_200) do |response|
      handle_response(response).should == 'a request body'
    end
  end

  it 'should complain about creds for a 401' do
    fake_env_401 = {
        :status => 401,
        :body => 'these are not the credentials you are looking for'
    }
    response_401 = Faraday::Response.new(fake_env_401)

    begin
      Crowdtilt.module_exec(response_401) do |response|
        handle_response(response)
      end
    rescue Crowdtilt::ApiError => e
      e.message.should == 'Invalid credentials'
      e.response.should == response_401.to_hash
    end
  end

  it "should return the request's error when it has one" do
    fake_env_4xx = {
        :status => 404,
        :body => {
            'error' => 'custom error'
        }
    }
    response_4xx = Faraday::Response.new(fake_env_4xx)

    begin
      Crowdtilt.module_exec(response_4xx) do |response|
        handle_response(response)
      end
    rescue Crowdtilt::ApiError => e
      e.message.should == 'custom error'
      e.response.should == response_4xx.to_hash
      e.response[:body]['error'].should == 'custom error'
    end
  end

  it "should not know what to do do when response has no error" do
    fake_env = {
        :status => 404,
        :body => {}
    }
    fake_response = Faraday::Response.new(fake_env)

    begin
      Crowdtilt.module_exec(fake_response) do |response|
        handle_response(response)
      end
    rescue Crowdtilt::ApiError => e
      e.message.should == 'Unknown error'
      e.response.should == fake_response.to_hash
    end
  end

end