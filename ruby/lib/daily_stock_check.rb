class DailyStockCheck

  def initialize(items)
    @items = items
  end

  def update_items
    @items.each { |item| update_item(item) }
  end

  def update_item(item)
    case item.name
    when "Sulfuras, Hand of Ragnaros"
      return item
    when "Aged Brie"
      update_aged_brie(item)
    when "Backstage passes to a TAFKAL80ETC concert"
      update_backstage_passes(item)
    else
      update_regular_item(item)
    end
  end

  private

  def update_regular_item(item)
    item.sell_in -= 1
    return if item.quality == 0
    item.quality -= 1
    item.quality -= 1 if item.sell_in < 0
  end

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

  def aged_brie?(item)
    item.name == "Aged Brie"
  end

  def backstage_passes?(item)
    item.name == "Backstage passes to a TAFKAL80ETC concert"
  end

  def sulfuras?(item)
    item.name == "Sulfuras, Hand of Ragnaros"
  end

  def regular_item?(item)
    item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert"
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
