class DailyStockCheck

  def initialize(items)
    @items = items
  end

  def update_items
    @items.each { |item| update_item(item) }
  end

  def update_item(item)
    return item if sulfuras?(item)
    update_aged_brie(item) if aged_brie?(item)
    update_backstage_passes(item) if backstage_passes?(item)
    if regular_item?(item)
      item.sell_in -= 1
      if item.quality > 0 && item.sell_in >= 0
        reduce_item_quality_by_one(item)
      end
      if item.sell_in < 0 && item.quality > 1
        reduce_item_quality_by_two(item)
      end
    end
  end

  private

  def update_aged_brie(item)
    increase_item_quality_by_one(item) if item.quality < 50
    reduce_item_sell_in_by_one(item)
  end

  def update_backstage_passes(item)
    reduce_item_sell_in_by_one(item)
    increase_item_quality_by_three(item) if item.sell_in < 6 && item.quality < 50
    increase_item_quality_by_two(item) if item.sell_in.between?(6,10) && item.quality < 50
    increase_item_quality_by_one(item) if item.sell_in > 10 && item.quality < 50
    item.quality = 0 if item.sell_in < 0
  end

  def reduce_item_sell_in_by_one(item)
    item.sell_in -= 1
  end

  def reduce_item_quality_by_one(item)
    item.quality -= 1
  end

  def increase_item_quality_by_one(item)
    item.quality += 1
  end

  def increase_item_quality_by_two(item)
    item.quality += 2
  end

  def increase_item_quality_by_three(item)
    item.quality += 3
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

  def reduce_item_quality_by_two(item)
    item.quality -= 2
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
