# frozen_string_literal: true

class Fin::Expenses::ParseData
  BASE_TAG = "li"

  def initialize(data:)
    @data = data
  end

  def parse
    raw_expenses.map do |raw_expense|
      Fin::Expenses::ParseExpense
        .new(raw_expense: raw_expense)
        .parse
    end
  end

  private

  attr_reader :data

  def raw_expenses
    Nokogiri::HTML(data, nil, Encoding::UTF_8.to_s).css(BASE_TAG)
  end
end
