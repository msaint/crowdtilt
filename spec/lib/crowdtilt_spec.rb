require 'spec_helper'

describe "Configuring" do
  it "should exception if api creds are missing" do
    expect {
      Crowdtilt.configure
    }.to raise_error(ArgumentError)
  end
  
  it "should exception if api creds are incomplete" do
    expect {
      Crowdtilt.configure :api_key => "hello"
    }.to raise_error(ArgumentError)
  end

  it "should pass if api creds are complete" do
    Crowdtilt.configure :api_key => "key", :api_secret => "secret"
    Crowdtilt.api_key.should == "key"
    Crowdtilt.api_secret.should == "secret"
    Crowdtilt.mode.should == "sandbox"
    Crowdtilt.url.should == "https://api-sandbox.crowdtilt.com"
  end
  
  it "should hit production if mode is set to production" do
    Crowdtilt.configure :api_key => "key", :api_secret => "secret", :mode => "production"
    Crowdtilt.api_key.should == "key"
    Crowdtilt.api_secret.should == "secret"
    Crowdtilt.mode.should == "production"
    Crowdtilt.url.should == "https://api.crowdtilt.com"
  end

end