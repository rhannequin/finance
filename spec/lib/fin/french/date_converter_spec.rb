# frozen_string_literal: false

require "rails_helper"

describe Fin::French::DateConverter do
  subject { described_class.new(date) }

  let(:date) { "vendredi 20 janv. 2020" }

  describe "#convert" do
    shared_examples "it converts to a Date object" do
      it "converts to a Date object" do
        expect(subject.convert).to be_a(Date)
      end
    end

    described_class::DAYS.each do |day|
      context "when day is #{day}" do
        let(:date) { "#{day} 20 janv. 2020" }

        include_examples "it converts to a Date object"
      end
    end

    described_class::MONTHS.each do |month|
      context "when month is #{month}" do
        let(:date) { "vendredi 20 #{month} 2020" }

        include_examples "it converts to a Date object"
      end
    end
  end
end
