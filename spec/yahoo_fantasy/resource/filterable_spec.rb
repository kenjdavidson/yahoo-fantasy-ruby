# frozen_string_literal: true

RSpec.describe YahooFantasy::Resource::Filterable do
  let(:filtered_class) do
    Class.new do
      include YahooFantasy::Resource::Filterable

      filter :name, value_type: String
      filter :active, values: [true, false]
    end
  end

  context 'FilterableClass' do
    subject { filtered_class }

    it 'has two defined filters filters' do
      expect(filtered_class.filters.keys.length).to eq 2
    end

    it 'has a filter named :name' do
      expect(filtered_class.filters.keys.include?(:name)).to eq true
      expect(filtered_class.filters[:name][:value_type]).to be(String)
    end

    it 'has a filter named :active with options [true, false]' do
      expect(filtered_class.filters.keys.include?(:active)).to eq true
      expect(filtered_class.filters[:active][:values]).to eq([true, false])
    end
  end
end
