require 'spec_helper'

describe "Configuring" do
  it "should exception if api creds are missing" do
    expect {
      Crowdtilt.new 
    }.to raise_error(ArgumentError)
  end
  
  it "should exception if api creds are incomplete" do
    expect {
      Crowdtilt.new api_key: "hello"
    }.to raise_error(ArgumentError)
  end

  it "should pass if api creds are complete" do
    c = Crowdtilt.new api_key: "key", api_secret: "secret"
    c.api_key.should == "key"
    c.api_secret.should == "secret"
  end

end