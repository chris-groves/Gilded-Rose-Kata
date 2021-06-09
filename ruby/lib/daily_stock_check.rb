require_relative "regular_item"
require_relative "aged_brie"

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
      update_backstage_passes(item)
    else
      RegularItem.new(item).update
    end
  end

  private

  def update_aged_brie(item)
    item.sell_in -= 1
    item.quality += 1 if item.quality < 50
  end

  def update_backstage_passes(item)
    item.sell_in -= 1
    return item.quality = 0 if item.sell_in < 0

    item.quality += 1
    return if item.quality >= 50

    item.quality += 1 if item.sell_in < 11
    item.quality += 1 if item.sell_in < 6
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
