require 'rspec'
require './receipt'

describe Receipt do

  let (:receipt) { Receipt.new }

  describe '#add_item' do
    it 'requests for a tax rate' do
      expect(TaxesManager).to receive(:get_tax_rate).with('book').and_return(0)
      receipt.add_item 1, 'book', 1
    end
  end

  describe '#sales_taxes_total' do
    it 'calculates sales taxes based on a rate' do
      expect(TaxesManager).to receive(:get_tax_rate).with('book').and_return(0.1)
      receipt.add_item 1, 'book', 1
      expect(receipt.sales_taxes_total).to eq(0.1)
    end

    it 'rounds sales tax to the nearest 0.05' do
      expect(TaxesManager).to receive(:get_tax_rate).with('book').and_return(0.01)
      receipt.add_item 1, 'book', 1
      expect(receipt.sales_taxes_total).to eq(0.05)
    end
  end

  describe '#price_total' do
    it 'returns total price including taxes' do
      expect(TaxesManager).to receive(:get_tax_rate).with('book').and_return(0.01)
      receipt.add_item 2, 'book', 1
      expect(receipt.price_total).to eq(2.05)
    end
  end


  describe '#print_receipt' do
    it 'displays appropriate result' do
      receipt = Receipt.new
      receipt.add_item '1', 'book', '12.49'
      receipt.add_item '1', 'music cd', '14.99'
      receipt.add_item '1', 'chocolate bar', '0.85'

      res = receipt.print_receipt
      expect(res).to include('1, book, 12.49')
      expect(res).to include('1, music cd, 16.49')
      expect(res).to include('1, chocolate bar, 0.85')
      expect(res).to include('Sales Taxes: 1.50')
      expect(res).to include('Total: 29.83')
    end
  end
end