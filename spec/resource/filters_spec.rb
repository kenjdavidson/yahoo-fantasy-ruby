RSpec.describe YahooFantasy::Resource::Filters do
  class FilterableClass 
    include YahooFantasy::Resource::Filters

    filter :name
    filter :active, true, false
  end

  context FilterableClass do 
    it "has two defined filters filters" do
      expect(FilterableClass.filters.keys.length).to eq 2
    end

    it "has a filter named :name with no options" do 
      expect(FilterableClass.filters.keys.include?(:name)).to eq true
      expect(FilterableClass.filters[:name]).to eq []
    end 

    it "has a filter named :active with options [true, false]" do 
      expect(FilterableClass.filters.keys.include?(:active)).to eq true
      expect(FilterableClass.filters[:active]).to eq [true, false]
    end 
  end 
end
