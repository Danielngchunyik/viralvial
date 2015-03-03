class CampaignPresenter < BasePresenter
  presents :campaign

  def time_remaining

    difference_in_seconds = ((@campaign.end_date - @campaign.start_date).abs).round
    components = []

    %w(year month week day).each do |interval|
      # For each interval type, if the amount of time remaining is greater than
      # one unit, calculate how many units fit into the remaining time.
      if difference_in_seconds >= 1.send(interval)
        delta = (difference_in_seconds / 1.send(interval)).floor
        difference_in_seconds -= delta.send(interval)
        components << pluralize(delta, interval)
      end
    end

    components.join(", ")
  end

  def title
    @campaign.title || "No Title"
  end

  def description
    @campaign.description || "No Description"
  end

  def organizer
    @campaign.organizer || "No Organizer"
  end

  def start_date
    convert_date(@campaign.start_date)
  end

  def end_date
    convert_date(@campaign.end_date)
  end

  def banner
    @campaign.banner.display
  end

  def image
    @campaign.image.show
  end

  private

  def convert_date(date)
    "#{date.day.ordinalize of Date::MONTHNAMES[date.month]}, #{date.year}"
  end
end
