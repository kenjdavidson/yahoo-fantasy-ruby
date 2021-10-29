RSpec.describe YahooFantasy::Resource::Subresources do
  class SubResourcedClass 
    include YahooFantasy::Resource::Subresources

    subresource :subresource1, self.class
    subresource :subresource2, self.class
  end

  context SubResourcedClass do 
    it "has two subresources" do  
      expect(SubResourcedClass.subresources.keys.length).to eq 2
    end

    it "has a subresource named :subresource1 defined by Class" do 
      expect(SubResourcedClass.subresources.keys.include?(:subresource1)).to eq true
      expect(SubResourcedClass.subresources[:subresource1]).to eq Class
    end 

    it "has a subresource named :subresource2 defined by Class" do 
      expect(SubResourcedClass.subresources.keys.include?(:subresource2)).to eq true
      expect(SubResourcedClass.subresources[:subresource2]).to eq Class
    end 
  end 
end
