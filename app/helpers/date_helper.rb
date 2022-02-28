module DateHelper
  def check_date_helper(date)
    date.to_date < 3.years.ago || date.to_date > Time.zone.now.to_date
  end
end
