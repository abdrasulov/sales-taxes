class TaxesManager

  def self.get_tax_rate(product)
    import_duty = product.include?('imported') ? 0.05 : 0
    product.sub! /imported\s+/, ''

    basic_sales_tax = is_exempt?(product) ? 0 : 0.1
    (basic_sales_tax + import_duty).round(2)
  end

  def self.is_exempt?(product)
    ['book', 'food', 'medical product', 'chocolate bar'].include? product
  end

end
