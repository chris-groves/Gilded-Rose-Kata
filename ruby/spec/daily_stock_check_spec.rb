require 'daily_stock_check'

describe DailyStockCheck do
  describe "#update_items" do
    context 'Aged Brie' do
      it 'increases the quality' do
        items = [Item.new("Aged Brie", 10, 10)]
        described_class.new(items).update_items
        expect(items[0].quality).to eq 11
      end

      it 'does not increase the quality above 50' do
        items = [Item.new("Aged Brie", 10, 50)]
        described_class.new(items).update_items
        expect(items[0].quality).to eq 50
      end
    end

    context 'Sulfuras, Hand of Ragnaros' do
      it 'does not reduce the sell in' do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
        described_class.new(items).update_items
        expect(items[0].sell_in).to eq 0
      end

      it 'does not change the quality' do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
        described_class.new(items).update_items
        expect(items[0].quality).to eq 80
      end
    end

    context 'Backstage Passes' do
      it 'increases the quality' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 20, 10)]
        described_class.new(items).update_items
        expect(items[0].quality).to eq 11
      end

      it 'increases the quality by 2 when sell in is between 10 and 6 inclusive' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 10)]
        described_class.new(items).update_items
        expect(items[0].quality).to eq 12
      end

      it 'increases the quality by 3 when sell in is 5 or less' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 10)]
        described_class.new(items).update_items
        expect(items[0].quality).to eq 13
      end

      it 'decreases the quality to 0 after the event' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)]
        described_class.new(items).update_items
        expect(items[0].quality).to eq 0
      end
    end

    context 'for any other item' do
      it "does not change the name" do
        items = [Item.new("foo", 0, 0)]
        described_class.new(items).update_items()
        expect(items[0].name).to eq "foo"
      end

      it 'reduces the sell in by 1' do
        items = [Item.new("Apples", 50, 50)]
        described_class.new(items).update_items
        expect(items[0].sell_in).to eq 49
      end

      it 'does not reduce the quality below 0' do
        items = [Item.new("Apples", 10, 10)]
        11.times { described_class.new(items).update_items }
        expect(items[0].quality).to eq 0
      end

      context 'sell by date has not been reached' do
        it 'reduces the quality of am item by 1' do
          items = [Item.new("Apples", 50, 50)]
          described_class.new(items).update_items
          expect(items[0].quality).to eq 49
        end
      end

      context 'sell by date has passed' do
        it 'reduces the quality of an item by 2' do
          items = [Item.new("Apples", 10, 50)]
          11.times { described_class.new(items).update_items }
          expect(items[0].quality).to eq 38
        end
      end
    end
  end
end
