class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors =[]
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.inventory.keys.include?(item)
    end
  end

  def available_items
    @vendors.flat_map do |vendor|
      vendor.inventory.keys
    end.uniq
  end

  def total_quantity_of_item(item)
    total_number = 0
    @vendors.each do |vendor|
      if vendor.inventory.keys.include?(item)
        total_number += vendor.inventory[item]
      end
    end
    total_number
  end

  def total_inventory
    inventory = {}
    available_items.each do |item|
      inventory[item] = {quantity: total_quantity_of_item(item), vendors: vendors_that_sell(item)}
    end
    inventory
  end

  def overstocked_items
    overstock = []
    total_inventory.each do |key, value|
      if value[:vendors].count > 1 && value[:quantity] > 50
        overstock << key
      end
    end
    overstock
  end

  def sorted_item_list
    available_items.map do |item|
      item.name
    end.sort
  end

end
