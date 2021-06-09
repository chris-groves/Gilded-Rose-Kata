class RegularItem
  attr_accessor :name, :sell_in, :quality

  def initialize(item)
    @item = item
  end

  def update
    @item.sell_in -= 1
    return if @item.quality == 0

    @item.quality -= 1
    @item.quality -= 1 if @item.sell_in < 0 && @item.quality > 0
  end
end
