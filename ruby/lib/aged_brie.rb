class AgedBrie
  attr_accessor :name, :sell_in, :quality

  def initialize(item)
    @item = item
  end

  def update
    @item.sell_in -= 1
    @item.quality += 1 if @item.quality < 50
  end
end
