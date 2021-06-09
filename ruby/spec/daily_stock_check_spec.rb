require "daily_stock_check"

describe DailyStockCheck do
  describe "#update_item" do
    context "when there are no items" do
      it "returns an empty array" do
        items = []
        expect(described_class.new(items).update_items).to eq []
      end
    end

    context "when an invalid item is updated" do
      it "returns an error" do
        items = "string"
        expect{ described_class.new(items).update_items}.to raise_error "Items needs to be an array"
      end
    end

    context "Normal items" do
      it "does not change the name" do
        items = [Item.new(name:"Apples",sell_in: 0, quality: 0)]
        described_class.new(items).update_items
        expect(items[0].name).to eq "Apples"
      end

      it "reduces the sell in by 1" do
        items = [Item.new(name: "Apples", sell_in: 50, quality: 50)]
        described_class.new(items).update_items
        expect(items[0].sell_in).to eq 49
      end

      it "reduces the quality in by 1" do
        items = [Item.new(name: "Apples", sell_in: 50, quality: 50)]
        described_class.new(items).update_items
        expect(items[0].sell_in).to eq 49
      end

      it "does not reduce the quality below 0" do
        items = [Item.new(name: "Apples", sell_in: 10, quality: 0)]
        described_class.new(items).update_items
        expect(items[0].quality).to eq 0
      end

      context "when sell by date has passed" do
        it "reduces the quality of an item by 2" do
          items = [Item.new(name: "Apples", sell_in: -1, quality: 50)]
          described_class.new(items).update_items
          expect(items[0].quality).to eq 48
        end
      end
    end
    context "Aged Brie" do
      it "reduces the sell in by 1" do
        items = [Item.new(name: "Aged Brie", sell_in: 50, quality: 50)]
        described_class.new(items).update_items
        expect(items[0].sell_in).to eq 49
      end

      it "increases the quality" do
        items = [Item.new(name: "Aged Brie", sell_in: 10, quality: 10)]
        described_class.new(items).update_items
        expect(items[0].quality).to eq 11
      end

      it "does not increase the quality above 50" do
        items = [Item.new(name: "Aged Brie", sell_in: 10, quality: 50)]
        described_class.new(items).update_items
        expect(items[0].quality).to eq 50
      end
    end

    context "Sulfuras, Hand of Ragnaros" do
      it "does not reduce the sell in" do
        items = [Item.new(name: "Sulfuras, Hand of Ragnaros", sell_in: 0, quality: 80)]
        described_class.new(items).update_items
        expect(items[0].sell_in).to eq 0
      end

      it "does not change the quality" do
        items = [Item.new(name: "Sulfuras, Hand of Ragnaros", sell_in: 0, quality: 80)]
        described_class.new(items).update_items
        expect(items[0].quality).to eq 80
      end
    end

    context "Backstage Passes" do
      it "increases the quality" do
        items = [Item.new(name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 20, quality: 10)]
        described_class.new(items).update_items
        expect(items[0].quality).to eq 11
      end

      it "increases the quality by 2 when sell in is between 10 and 6 inclusive" do
        items = [Item.new(name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 10, quality: 10)]
        described_class.new(items).update_items
        expect(items[0].quality).to eq 12
      end

      it "increases the quality by 3 when sell in is 5 or less" do
        items = [Item.new(name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 5, quality: 10)]
        described_class.new(items).update_items
        expect(items[0].quality).to eq 13
      end

      it "decreases the quality to 0 after the event" do
        items = [Item.new(name:"Backstage passes to a TAFKAL80ETC concert", sell_in: 0, quality: 10)]
        described_class.new(items).update_items
        expect(items[0].quality).to eq 0
      end
    end
  end
end
