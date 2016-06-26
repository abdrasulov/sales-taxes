require './receipt'
require 'csv'

class App
  class << self

    def run
      filepath = ARGV[0]
      if filepath.nil?
        print help
      else
        receipt = Receipt.new
        CSV.foreach filepath, headers: :first_row, col_sep: ', ' do |row|
          receipt.add_item row[0], row[1], row[2]
        end
        print receipt.print_receipt
      end
    end

    def help
      "Please specify path to input csv file\n"
    end

  end
end
