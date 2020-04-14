class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      update_item(item)
    end
  end

  def update_item(item)
    return item if item.name == "Sulfuras, Hand of Ragnaros"
    if aged_brie?(item)
      if item.quality < 50
        increase_item_quality_by_one(item)
        item.sell_in -= 1
      else
        item.sell_in -= 1
      end
    end
    if backstage_passes?(item)
      if item.sell_in < 11 && item.quality < 50
        increase_item_quality_by_one(item)
      end
      if item.sell_in < 6 && item.quality < 50
        increase_item_quality_by_one(item)
      end
    end

    if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
      if item.quality > 0
        reduce_item_quality_by_one(item)
      end
    else
      if item.quality < 50 && item.name != "Aged Brie"
        increase_item_quality_by_one(item)
      end
    end
    item.sell_in = item.sell_in - 1
    if item.sell_in < 0
      if item.name != "Aged Brie"
        if item.name != "Backstage passes to a TAFKAL80ETC concert"
          if item.quality > 0
            reduce_item_quality_by_one(item)
          end
        else
          item.quality = item.quality - item.quality
        end
      else
        if item.quality < 50
          increase_item_quality_by_one(item)
        end
      end
    end
  end

  def reduce_item_quality_by_one(item)
    item.quality -= 1
  end

  def increase_item_quality_by_one(item)
    item.quality += 1
  end

  def aged_brie?(item)
    item.name == "Aged Brie"
  end

  def backstage_passes?(item)
    item.name == "Backstage passes to a TAFKAL80ETC concert"
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
