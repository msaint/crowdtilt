require 'spec_helper'

describe "ApiError" do

  it "should keep track of an object" do
    hash = {foo: 'some data'}
    exception = Crowdtilt::ApiError.new('a message', hash)
    exception.response.should == hash
  end

  it 'should do normal StandardError things' do
    hash = {foo: 'some more data'}
    exception = Crowdtilt::ApiError.new('a message', hash)
    exception.message.should == 'a message'

    begin
      raise Crowdtilt::ApiError.new('whoops', {body: 'response body'})
    rescue Crowdtilt::ApiError => e
      e.message.should == 'whoops'
      e.backtrace.should be_an Array
    end
  end
end