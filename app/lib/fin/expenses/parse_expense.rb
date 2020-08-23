# frozen_string_literal: true

class Fin::Expenses::ParseExpense
  AMOUNT_CLASS = "amount"
  CURRENCY_SYMBOL = "€"
  DEFAULT_CURRENCY_DELEMITER = ","
  STANDARD_CURRENCY_DELEMITER = "."

  DATE_CLASS = "headerDate"
  DESCRIPTION_CLASSES = %w[dbl fw6 elp].freeze
  CATEGORY_CLASSES = %w[dbl fs08 fc2a elp text].freeze

  def initialize(raw_expense:)
    @raw_expense = raw_expense
  end

  def parse
    @amount = parse_amount
    @date = parse_date
    @description = parse_description
    @category = parse_category

    expense_attributes
  end

  private

  attr_reader :raw_expense

  def expense_attributes
    {
      amount: @amount,
      date: @date,
      description: @description,
      category: @category,
    }
  end

  def parse_amount
    raw_expense
      .at_css(".#{AMOUNT_CLASS}")
      .text
      .delete(CURRENCY_SYMBOL)
      .strip
      .gsub(DEFAULT_CURRENCY_DELEMITER, STANDARD_CURRENCY_DELEMITER)
      .to_d
  end

  def parse_date
    Fin::French::DateConverter.new(
      raw_expense
        .at_css(".#{DATE_CLASS}")
        .text
        .strip
    ).convert
  end

  def parse_description
    raw_expense
      .at_css(".#{DESCRIPTION_CLASSES.join(".")}")
      .text
      .strip
  end

  def parse_category
    raw_expense
      .at_css(".#{CATEGORY_CLASSES.join(".")}")
      .text
      .strip
  end
end
