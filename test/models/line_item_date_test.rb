require "test_helper"

class LineItemDateTest < ActiveSupport::TestCase
  def setup
    @quote = quotes(:first)
    @line_item_date = @quote.line_item_dates.build(date: Date.tomorrow)
  end

  test "should be valid with valid attributes" do
    assert @line_item_date.valid?
  end

  test "should not be valid without a date" do
    @line_item_date.date = nil
    assert_not @line_item_date.valid?
  end

  test "should belong to a quote" do
    assert_equal @quote, @line_item_date.quote
  end

  test "should save with valid attributes" do
    assert_difference -> { @quote.line_item_dates.count }, 1 do
      @line_item_date.save
    end
  end

  test "should not save without a date" do
    @line_item_date.date = nil
    assert_no_difference -> { @quote.line_item_dates.count } do
      @line_item_date.save
    end
  end

  test "#previous_date returns the previous date when it exists" do
    assert_equal line_item_dates(:today), line_item_dates(:next_week).previous_date
  end

  test "#previous_date returns nil if it does not exist" do
    assert_nil line_item_dates(:today).previous_date
  end
end
