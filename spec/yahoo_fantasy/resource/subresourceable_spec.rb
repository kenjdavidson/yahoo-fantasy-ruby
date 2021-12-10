# frozen_string_literal: true

RSpec.describe YahooFantasy::Resource::Subresourceable do
  before do
    test_resource = Class.new(YahooFantasy::Resource::Base) do
      include YahooFantasy::Resource::Subresourceable
      include YahooFantasy::Resource::Filterable

      subresource :subresource, filters: { filter1: {}, filter2: {} }
    end
    stub_const('TestResource', test_resource)
  end

  context '.subresource' do
    subject { resourced_class }

    it 'has two subresources' do
      expect(TestResource.subresources.keys.length).to eq 1
    end

    it 'has a subresource named :subresource1 defined' do
      expect(TestResource.subresources.keys.include?(:subresource)).to eq true
    end
  end

  context 'subresource accessor methods' do
    subject { TestResource.new }

    it 'responds to subresource' do
      expect(subject.respond_to?(:subresource)).to eq(true)
    end

    it 'responds to subresource=' do
      expect(subject.respond_to?('subresource=')).to eq(true)
    end

    it 'responds to subresource!' do
      expect(subject.respond_to?('subresource!')).to eq(true)
    end
  end

  context '.subresource_path' do
    subject { TestResource.new(test_resource_key: '123') }

    it 'creates appropriate Subresource path' do
      subresource = TestResource.subresources[:subresource]
      expect(subject.subresource_path(subresource)).to eq('/test_resource//subresource')
    end
  end

  context '.out_params' do
    it 'returns empty if no out parameters' do
      expect(TestResource.out_params).to eq('')
    end

    it 'returns string out parameters' do
      expect(TestResource.out_params('subresource1,subresource2')).to eq(';out=subresource1,subresource2')
    end

    it 'returns Arrau out parameters' do
      expect(TestResource.out_params(%w[subresource1 subresource2])).to eq(';out=subresource1,subresource2')
    end
  end
end
