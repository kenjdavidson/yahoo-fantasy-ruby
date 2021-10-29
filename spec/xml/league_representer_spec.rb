RSpec.describe YahooFantasy::XML::GameRepresenter do 
  subject(:game) { YahooFantasy::Resource::Game.new }

  before(:example) do 
    access_token = double("access_token", request: {})
    YahooFantasy::Resource::Base.access_token = access_token
  end 

  context "single <league> with no subresources" do

  end
end