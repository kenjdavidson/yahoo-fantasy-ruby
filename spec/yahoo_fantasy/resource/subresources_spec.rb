# frozen_string_literal: true

# Testing class definition
class SubResourcedClass
  include YahooFantasy::Resource::Subresources

  subresource :subresource1, String
  subresource :subresource2, Array
end

RSpec.describe YahooFantasy::Resource::Subresources do
  context SubResourcedClass do
    it 'has two subresources' do
      expect(SubResourcedClass.subresources.keys.length).to eq 2
    end

    it 'has a subresource named :subresource1 defined by String' do
      expect(SubResourcedClass.subresources.keys.include?(:subresource1)).to eq true
      expect(SubResourcedClass.subresources[:subresource1]).to eq String
    end

    it 'has a subresource named :subresource2 defined by Array' do
      expect(SubResourcedClass.subresources.keys.include?(:subresource2)).to eq true
      expect(SubResourcedClass.subresources[:subresource2]).to eq Array
    end
  end
end
