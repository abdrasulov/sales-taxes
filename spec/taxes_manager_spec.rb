require 'rspec'
require './taxes_manager'

describe TaxesManager do
  describe '.get_tax_rate' do
    it 'returns 0 for exempt' do
      expect(TaxesManager.get_tax_rate 'book').to eq 0
      expect(TaxesManager.get_tax_rate 'food').to eq 0
      expect(TaxesManager.get_tax_rate 'medical product').to eq 0
    end

    it 'returns 0.1 for all goods, except exempts' do
      expect(TaxesManager.get_tax_rate 'music cd').to eq 0.1
      expect(TaxesManager.get_tax_rate 'bottle of perfume').to eq 0.1
    end

    it 'adds additional import duty for all goods' do
      expect(TaxesManager.get_tax_rate 'imported music cd').to eq 0.15
      expect(TaxesManager.get_tax_rate 'imported book').to eq 0.05
    end
  end
end
