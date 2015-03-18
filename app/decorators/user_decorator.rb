class UserDecorator < BaseDecorator

  def birthday_day
    birthday.try(:day)
  end

  def birthday_month
    birthday.try(:month)
  end

  def birthday_year
    birthday.try(:year)
  end

  def race
    try(:race)
  end

  def age
    birthday && ((Date.today - birthday) / 365.25)
  end
end