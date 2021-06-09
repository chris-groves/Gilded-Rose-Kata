require_relative "regular_item"
require_relative "aged_brie"
require_relative "backstage_passes"

class DailyStockCheck
  attr_accessor :items, :item

  def initialize(items)
    @items = items
  end

  def update_items
    raise StandardError.new "Items needs to be an array" unless @items.is_a?(Array)
    @items.each { |item| update_item(item) }
  end

  def update_item(item)
    case item.name
    when "Sulfuras, Hand of Ragnaros"
      return item
    when "Aged Brie"
      AgedBrie.new(item).update
    when "Backstage passes to a TAFKAL80ETC concert"
      BackstagePasses.new(item).update
    else
      RegularItem.new(item).update
    end
  end
end

# don't change
class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
