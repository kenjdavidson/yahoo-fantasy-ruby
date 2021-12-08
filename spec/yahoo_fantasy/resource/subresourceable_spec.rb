# frozen_string_literal: true

RSpec.describe YahooFantasy::Resource::Subresourceable do
  let(:resourced_class) do
    Class.new(YahooFantasy::Resource::Base) do
      include YahooFantasy::Resource::Subresourceable
      include YahooFantasy::Resource::Filterable

      subresource :subresource, filters: { filter1: {}, filter2: {} }

      def resource_path
        '/resource/1'
      end
    end
  end

  context 'SubresourcedClass definition' do
    subject { resourced_class }

    it 'has two subresources' do
      expect(resourced_class.subresources.keys.length).to eq 1
    end

    it 'has a subresource named :subresource1 defined' do
      expect(resourced_class.subresources.keys.include?(:subresource)).to eq true
    end
  end

  context 'subresource accessor methods' do
    subject { resourced_class.new }

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
    subject { resourced_class.new }

    it 'creates appropriate Subresource path' do
      subresource = resourced_class.subresources[:subresource]
      expect(subject.subresource_path(subresource)).to eq('/resource/1/subresource')
    end
  end
end
