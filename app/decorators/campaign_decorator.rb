class CampaignDecorator < BaseDecorator
  
  def time_remaining
    distance_of_time_in_words(Date.today, model.end_date).titleize
  end

  def title
   model.title || "No Title"
  end

  def description
    model.description || "No Description"
  end

  def organizer
    model.organizer || "No Organizer"
  end

  def start_date
    convert_date(model.start_date)
  end

  def end_date
    convert_date(model.end_date)
  end

  def banner
    model.banner.display
  end

  def image
    model.image.show
  end

  def topics
    model.topics
  end

  private

  def convert_date(date)
    "#{date.day.ordinalize} of #{Date::MONTHNAMES[date.month]}, #{date.year}"
  end
end
