require 'rspec'
require './app'

describe App do
  describe '.run' do
    let(:filepath) { 'spec/fixtures/input1.csv' }
    let(:receipt) {double 'Receipt'}
    let(:result) { 'result' }
    before { expect(ARGV).to receive(:[]).with(0).and_return(filepath) }
    it 'adds item to receipt and outputs the result' do
      expect(Receipt).to receive(:new).and_return(receipt)
      expect(receipt).to receive(:add_item).exactly(3).times
      expect(receipt).to receive(:print_receipt).and_return(result)
      expect { App.run }.to output(result).to_stdout
    end
  end
end