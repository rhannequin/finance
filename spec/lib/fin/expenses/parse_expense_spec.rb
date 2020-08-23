# frozen_string_literal: true

require "rails_helper"

describe Fin::Expenses::ParseExpense do
  subject { described_class.new(raw_expense: Nokogiri::HTML(raw_expense)) }

  let(:amount) { 20 }
  let(:date) { "vendredi 20 janv. 2020" }
  let(:description) { "Vir /de J.D /ref" }
  let(:category) { "Groceries" }

  let(:raw_expense) do
    "
      <li>
        <span class=\"#{described_class::AMOUNT_CLASS}\">
          #{amount} #{described_class::CURRENCY_SYMBOL}
        </span>
        <span class=\"#{described_class::DATE_CLASS}\">
          #{date}
        </span>
        <span class=\"#{described_class::DESCRIPTION_CLASSES.join(" ")}\">
          #{description}
        </span>
        <span class=\"#{described_class::CATEGORY_CLASSES.join(" ")}\">
          #{category}
        </span>
      </li>
    "
  end

  describe "#parse" do
    describe "amount" do
      it "returns an amount attribute" do
        expect(subject.parse).to have_key(:amount)
        expect(subject.parse[:amount]).to eq(amount)
      end

      context "when amount is negative" do
        let(:amount) { "-20" }

        it "returns a negative amount attribute" do
          expect(subject.parse[:amount]).to eq(-20)
        end
      end

      context "when amount has decimal" do
        let(:amount) { "20,50" }

        it "returns a decimal amount attribute" do
          expect(subject.parse[:amount]).to eq(20.5)
        end
      end
    end

    describe "date" do
      it "uses a French date converter" do
        expect_any_instance_of(Fin::French::DateConverter).to(
          receive(:convert).and_call_original
        )
        subject.parse
      end

      it "returns a date attribute" do
        expect(subject.parse).to have_key(:date)
        expect(subject.parse[:date]).to be_present
      end
    end

    describe "description" do
      it "returns a description attribute" do
        expect(subject.parse).to have_key(:description)
        expect(subject.parse[:description]).to eq(description)
      end
    end

    describe "category" do
      it "returns a category attribute" do
        expect(subject.parse).to have_key(:category)
        expect(subject.parse[:category]).to eq(category)
      end
    end
  end
end
