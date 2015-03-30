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

  def age
    model.birthday && ((Date.today - model.birthday) / 365.25)
  end

  def has_linked_provider?(provider)
    model.authentications.where(provider: provider).present?
  end

  def score
    model.social_score.viral_score
  end
end