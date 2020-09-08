require 'gilded_rose'

describe GildedRose do
  context 'sell by date has not been reached' do
    it 'reduces the quality of an item by 1' do
      items = [Item.new("Apples", 50, 50)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 49
    end
  end

  context 'sell by date has passed' do
    it 'reduces the quality of an item by 2' do
      items = [Item.new("Apples", 10, 50)]
      11.times { GildedRose.new(items).update_quality }
      expect(items[0].quality).to eq 38
    end
  end

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it 'reduces the sell in of an item by 1' do
      items = [Item.new("Apples", 50, 50)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq 49
    end





    it 'does not reduce the quality of an item below 0' do
      items = [Item.new("Apples", 10, 10)]
      11.times { GildedRose.new(items).update_quality }
      expect(items[0].quality).to eq 0
    end

    it 'increases the quality of "Aged Brie"' do
      items = [Item.new("Aged Brie", 10, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 11
    end

    it 'does not increase the quality of an item above 50' do
      items = [Item.new("Aged Brie", 10, 50)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 50
    end

    it 'does not increase the quality of an item above 50' do
      items = [Item.new("Aged Brie", 10, 50)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 50
    end

    it 'does not reduce the sell in of "Sulfuras, Hand of Ragnaros"' do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq 0
    end

    it 'does not decrease the quality of "Sulfuras, Hand of Ragnaros"' do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 80
    end

    it 'increases the quality of "Backstage passes to a TAFKAL80ETC concert"' do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 20, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 11
    end

    it 'increases the quality by 2 of "Backstage passes to a TAFKAL80ETC concert" when sell in is between 10 and 6 inclusive' do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 12
    end

    it 'increases the quality by 3 of "Backstage passes to a TAFKAL80ETC concert" when sell in is 5 or less' do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 13
    end

    it 'decreases the quality to 0 of "Backstage passes to a TAFKAL80ETC concert" after the event' do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 0
    end
  end
end
