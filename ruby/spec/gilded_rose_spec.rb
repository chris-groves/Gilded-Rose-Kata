require 'gilded_rose'

describe GildedRose do
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

    it 'reduces the quality of an item by 1' do
      items = [Item.new("Apples", 50, 50)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 49
    end

    it 'reduces the quality of an item by 2' do
      items = [Item.new("Apples", 10, 50)]
      11.times { GildedRose.new(items).update_quality }
      expect(items[0].quality).to eq 38
    end
  end
end
