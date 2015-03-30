module User::UpdateActions

  # Update Actions
  def set_access_token(access_token, provider)
    auth = authentications.find_by(provider: provider)
    auth.update(token: access_token.try(:token), secret: access_token.try(:secret))
  end
  
  def main_interest=(value)
    self.primary_interest_list = value
  end

  def birthday_day=(value)
    self.birthday = birthday.change(day: value.to_i)
  end

  def birthday_month=(value)
    self.birthday = birthday.change(month: value.to_i)
  end

  def birthday_year=(value)
    self.birthday = birthday.change(year: value.to_i)
  end
end
