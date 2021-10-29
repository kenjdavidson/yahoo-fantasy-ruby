require "oauth2"

RSpec.describe YahooFantasy::Resource::Base do
  context "When no access_token is provided" do
    it "should respond negatively to access_token method(s)" do 
      expect(YahooFantasy::Resource::Base.access_token?).to eq(false)
      expect(YahooFantasy::Resource::Base.access_token).to eq(nil)
    end 
  end 

  context "When multiple threads configured with tokens" do 
    it "access_token(s) should not be maintained separately" do 
      access_token1 = double
      allow(access_token1).to receive(:request)

      access_token2 = double
      allow(access_token2).to receive(:request)

      thread1 = Thread.new do       
        YahooFantasy::Resource::Base.access_token = access_token1
        expect(YahooFantasy::Resource::Base.access_token?).to eq(true)
        expect(YahooFantasy::Resource::Base.access_token).to eq(access_token1)
      end

      thread2 = Thread.new do       
        YahooFantasy::Resource::Base.access_token = access_token2
        expect(YahooFantasy::Resource::Base.access_token?).to eq(true)
        expect(YahooFantasy::Resource::Base.access_token).to eq(access_token2)
      end 

      thread1.join
      thread2.join
    end 
  end 

  context "When an access token is provided" do 
    it "should receive #request method for GET /path with no options" do 
      access_token = spy(OAuth2::AccessToken)

      YahooFantasy::Resource::Base.access_token = access_token 
      YahooFantasy::Resource::Base.api(:get, "/path")

      expect(access_token).to have_received(:request).with(:get, "/path", {})
    end 
  end 
end