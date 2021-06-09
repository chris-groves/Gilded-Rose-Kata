require "regular_item"

describe RegularItem do
  describe "#update" do
    it "reduces sell_in by 1" do
      item = Item.new("Apple", 10, 10)
      regular_item = RegularItem.new(item)
      expect { regular_item.update }.to change { item.sell_in }.by(-1)
    end

    it "reduces quality by 1 when sell in is above 0" do
      item = Item.new("Apple", 10, 10)
      regular_item = RegularItem.new(item)
      expect { regular_item.update }.to change { item.quality }.by(-1)
    end

    it "reduces quality by 2 when sell in is below 0" do
      item = Item.new("Apple", -1, 2)
      regular_item = RegularItem.new(item)
      expect { regular_item.update }.to change { item.quality }.by(-2)
    end

    it "does not reduce quality below 0" do
      item = Item.new("Apple", 2, 0)
      regular_item = RegularItem.new(item)
      expect { regular_item.update }.to change { item.quality }.by(0)
    end
  end
end
