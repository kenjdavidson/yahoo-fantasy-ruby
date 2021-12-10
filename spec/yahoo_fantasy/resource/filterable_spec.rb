# frozen_string_literal: true

RSpec.describe YahooFantasy::Resource::Filterable do
  let(:filtered_class) do
    Class.new do
      include YahooFantasy::Resource::Filterable

      filter :name, type: String
      filter :active, values: [true, false]
    end
  end

  context '.filters' do
    subject { filtered_class }

    it 'returns correct filters' do
      expect(filtered_class.filters.keys.length).to eq 2
    end

    it 'has a filter named :name' do
      expect(filtered_class.filters.keys.include?(:name)).to eq true
      expect(filtered_class.filters[:name][:type]).to be(String)
      expect(filtered_class.filters[:name][:values]).to eq(nil)
    end

    it 'has a filter named :active with options [true, false]' do
      expect(filtered_class.filters.keys.include?(:active)).to eq true
      expect(filtered_class.filters[:active][:values]).to eq([true, false])
    end
  end

  context '.filter_params' do
    subject { filtered_class }

    it 'should return empty when none provided' do
      expect(filtered_class.filter_params).to eq('')
    end

    it 'should parse single string filter' do
      expect(filtered_class.filter_params(filter1: 'filter1')).to eq(';filter1=filter1')
    end

    it 'should parse single Array filter' do
      expect(filtered_class.filter_params(filter1: %w[filter1])).to eq(';filter1=filter1')
    end
  end
end
