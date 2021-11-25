# frozen_string_literal: true

RSpec.describe YahooFantasy::Resource::Subresourceable do
  let(:resourced_class) do
    Class.new do
      include YahooFantasy::Resource::Subresourceable

      subresource :subresource1
      subresource :subresource2
    end
  end

  context 'SubresourcedClass definition' do
    subject { resourced_class }

    it 'has two subresources' do
      expect(resourced_class.subresources.keys.length).to eq 2
    end

    it 'has a subresource named :subresource1 defined' do
      expect(resourced_class.subresources.keys.include?(:subresource1)).to eq true
    end

    it 'has a subresource named :subresource2 defined' do
      expect(resourced_class.subresources.keys.include?(:subresource2)).to eq true
    end
  end

  context 'instance of SubresourcedClass' do
    subject { resourced_class.new }

    it 'responds to subresource1' do
      expect(subject.respond_to?(:subresource1)).to eq(true)
    end

    it 'responds to subresource1=' do
      expect(subject.respond_to?('subresource1=')).to eq(true)
    end

    it 'responds to subresource2' do
      expect(subject.respond_to?(:subresource2)).to eq(true)
    end

    it 'responds to subresource2=' do
      expect(subject.respond_to?('subresource2=')).to eq(true)
    end
  end
end
