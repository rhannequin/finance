# frozen_string_literal: true

class Fin::Expenses::Import
  BASE_TAG = "li"

  def initialize(file_path:)
    @file_path = file_path
  end

  def perform
    Fin::Expenses::ParseData
      .new(data: file)
      .parse
  end

  private

  attr_reader :file_path

  def file
    File.read(file_path)
  end
end
