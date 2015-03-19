class UserDecorator < BaseDecorator

  def birthday_day
    model.birthday.try(:day)
  end

  def birthday_month
    model.birthday.try(:month)
  end

  def birthday_year
    model.birthday.try(:year)
  end

  def race
    model.try(:race)
  end

  def main_interest
    model.primary_interest_list.first
  end

  def interest_not_selected?
    model.primary_interest_list.empty?
  end        

  def age
    model.birthday && ((Date.today - model.birthday) / 365.25)
  end
end