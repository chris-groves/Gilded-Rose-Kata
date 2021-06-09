class BackstagePasses
  attr_accessor :item

  def initialize(item)
    @item = item
  end

  def update
    item.sell_in -= 1
    return item.quality = 0 if item.sell_in < 0

    item.quality += 1
    return if item.quality >= 50

    item.quality += 1 if item.sell_in < 11
    item.quality += 1 if item.sell_in < 6
  end
end
