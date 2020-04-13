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
    if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
      if item.quality > 0
        if item.name != "Sulfuras, Hand of Ragnaros"
          reduce_item_quality_by_one(item)
        end
      end
    else
      if item.quality < 50
        increase_item_quality_by_one(item)
        if item.name == "Backstage passes to a TAFKAL80ETC concert"
          if item.sell_in < 11
            if item.quality < 50
              increase_item_quality_by_one(item)
            end
          end
          if item.sell_in < 6
            if item.quality < 50
              increase_item_quality_by_one(item)
            end
          end
        end
      end
    end
    if item.name != "Sulfuras, Hand of Ragnaros"
      item.sell_in = item.sell_in - 1
    end
    if item.sell_in < 0
      if item.name != "Aged Brie"
        if item.name != "Backstage passes to a TAFKAL80ETC concert"
          if item.quality > 0
            if item.name != "Sulfuras, Hand of Ragnaros"
              reduce_item_quality_by_one(item)
            end
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
