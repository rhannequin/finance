# frozen_string_literal: true

require "rails_helper"

describe Fin::Expenses::Import do
  subject { described_class.new(file_path: "") }

  describe "#perform" do
    let(:parse_data_service_double) do
      instance_double(Fin::Expenses::ParseData, parse: true)
    end

    before do
      allow(File).to(
        receive(:read).and_return(StringIO.new(""))
      )

      allow(Fin::Expenses::ParseData).to(
        receive(:new).and_return(parse_data_service_double)
      )
    end

    it "runs a parsing service over the file" do
      expect(parse_data_service_double).to receive(:parse)
      subject.perform
    end
  end
end
