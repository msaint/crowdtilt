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

  it 'loads error_id' do
    e = Crowdtilt::ApiError.new('message', { :body => { 'error_id' => 'ERR_ID_TEST_WORKED' }} )
    expect(e.error_id).to eq('ERR_ID_TEST_WORKED')
  end
end