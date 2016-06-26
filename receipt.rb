require './taxes_manager'
class Receipt
  attr_reader :price_total
  attr_reader :sales_taxes_total

  def initialize
    @items = []
    @sales_taxes_total = 0
    @price_total = 0
  end

  def add_item(quantity, product, price_per_item)
    price_per_item = price_per_item.to_f
    quantity = quantity.to_i

    price_wo_taxes = price_per_item * quantity
    sales_tax = calculate_sales_tax(price_wo_taxes, product)
    price_with_taxes = ((price_wo_taxes + sales_tax) * 100).round / 100.0

    @sales_taxes_total = @sales_taxes_total + sales_tax
    @price_total = @price_total + price_with_taxes

    @items << {
        quantity: quantity,
        product: product,
        sales_tax: sales_tax,
        price: price_with_taxes,
    }
  end

  def calculate_sales_tax(price, product)
    sales_tax = price * TaxesManager.get_tax_rate(product)
    (sales_tax * 20).ceil / 20.0
  end

  def print_receipt
    output = []
    @items.each do |item|
      output << [item[:quantity], item[:product], item[:price]].join(', ')
    end
    output << ''
    output << "Sales Taxes: #{'%.2f' % @sales_taxes_total}"
    output << "Total: #{@price_total}"
    output << ''
    output.join("\n")
  end

end