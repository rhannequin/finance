# frozen_string_literal: true

require "rails_helper"

describe Fin::Expenses::ParseData do
  subject { described_class.new(data: data) }

  let(:data) do
    "
      <ul>
        #{expenses.join}
      </ul>
    "
  end

  let(:expenses) do
    [
      "<li>Expense 1</li>",
      "<li>Expense 2</li>",
    ]
  end

  let(:expense_attributes) do
    {
      amount: 20,
    }
  end

  describe "#parse" do
    before do
      allow_any_instance_of(Fin::Expenses::ParseExpense).to(
        receive(:parse).and_return(expense_attributes)
      )
    end

    it "runs a parsing service over each expense" do
      expect(Fin::Expenses::ParseExpense).to(
        receive(:new)
          .twice
          .and_call_original
      )
      subject.parse
    end

    it "returns an array of expenses attributes" do
      expect(subject.parse).to be_an(Array)
    end
  end
end
