class CampaignDecorator < SimpleDelegator
   
  def time_remaining
    distance_of_time_in_words(campaign.start_date, campaign.end_date)
  end

  def title
    campaign.title || "No Title"
  end

  def description
    campaign.description || "No Description"
  end

  def organizer
    campaign.organizer || "No Organizer"
  end

  def start_date
    convert_date(campaign.start_date)
  end

  def end_date
    convert_date(campaign.end_date)
  end

  def banner
    campaign.banner.display
  end

  def image
    campaign.image.show
  end

  private

  def convert_date(date)
    "#{date.day.ordinalize of Date::MONTHNAMES[date.month]}, #{date.year}"
  end
end
