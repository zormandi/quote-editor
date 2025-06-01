require "application_system_test_case"

class LineItemDatesTest < ApplicationSystemTestCase
  setup do
    login_as users(:manager)

    @quote = quotes(:first)
    @line_item_date = line_item_dates(:today)
  end

  test "Creating a new line item date" do
    visit quote_path(@quote)
    assert_selector "h1", text: "First quote"

    click_on "New date"
    assert_selector "h1", text: "First quote"
    fill_in "Date", with: Date.tomorrow

    click_on "Create date"
    assert_text I18n.l(Date.tomorrow, format: :long)
  end

  test "Updating a line item date" do
    visit quote_path(@quote)

    within id: dom_id(@line_item_date) do
      click_on "Edit"
    end

    assert_selector "h1", text: "First quote"

    within id: dom_id(@line_item_date) do
      fill_in "Date", with: Date.tomorrow
      click_on "Update date"
    end

    assert_text I18n.l(Date.tomorrow, format: :long)
  end

  test "Deleting a line item date" do
    visit quote_path(@quote)
    assert_text I18n.l(@line_item_date.date, format: :long)

    accept_confirm do
      within id: dom_id(@line_item_date) do
        click_on "Delete"
      end
    end

    assert_no_text I18n.l(@line_item_date.date, format: :long)
  end
end
