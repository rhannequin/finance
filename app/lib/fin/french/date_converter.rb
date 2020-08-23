# frozen_string_literal: true

class Fin::French::DateConverter
  TODAY = "Aujourd'hui"
  YESTERDAY = "Hier"

  DAYS = [
    MONDAY = "lundi",
    TUESDAY = "mardi",
    WEDNESDAY = "mercredi",
    THURSDAY = "jeudi",
    FRIDAY = "vendredi",
    SATURDAY = "samedi",
    SUNDAY = "dimanche",
  ].freeze

  MONTHS = [
    JANUARY = "janv.",
    FEBRUARY = "févr.",
    MARCH = "mars",
    APRIL = "avr.",
    MAY = "mai",
    JUNE = "juin",
    JULY = "juil.",
    AUGUST = "août",
    SEPTEMBER = "sept.",
    OCTOBER = "oct.",
    NOVEMBER = "nov.",
    DECEMBER = "déc.",
  ].freeze

  def initialize(str)
    @french_date = str
  end

  def convert
    return Time.zone.today if french_date == TODAY
    return Time.zone.yesterday if french_date == YESTERDAY

    remove_day_name!
    replace_month_name!
    Date.parse(french_date.strip)
  end

  private

  attr_reader :french_date

  def remove_day_name!
    french_date.remove!(MONDAY)
    french_date.remove!(TUESDAY)
    french_date.remove!(WEDNESDAY)
    french_date.remove!(THURSDAY)
    french_date.remove!(FRIDAY)
    french_date.remove!(SATURDAY)
    french_date.remove!(SUNDAY)
    french_date
  end

  def replace_month_name!
    french_date.gsub!(JANUARY, "january")
    french_date.gsub!(FEBRUARY, "february")
    french_date.gsub!(MARCH, "march")
    french_date.gsub!(APRIL, "april")
    french_date.gsub!(MAY, "may")
    french_date.gsub!(JUNE, "june")
    french_date.gsub!(JULY, "july")
    french_date.gsub!(AUGUST, "august")
    french_date.gsub!(SEPTEMBER, "september")
    french_date.gsub!(OCTOBER, "october")
    french_date.gsub!(NOVEMBER, "november")
    french_date.gsub!(DECEMBER, "december")
    french_date
  end
end
