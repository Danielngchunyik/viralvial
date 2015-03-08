class CampaignPresenter < BasePresenter
   
  def time_remaining
    distance_of_time_in_words(object.start_date, object.end_date)
  end

  def title
    object.title || "No Title"
  end

  def description
    object.description || "No Description"
  end

  def organizer
    object.organizer || "No Organizer"
  end

  def start_date
    convert_date(object.start_date)
  end

  def end_date
    convert_date(object.end_date)
  end

  def banner
    object.banner.display
  end

  def image
    object.image.show
  end

  private

  def convert_date(date)
    "#{date.day.ordinalize of Date::MONTHNAMES[date.month]}, #{date.year}"
  end
end
