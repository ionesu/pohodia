class Tour::FilterPeriod
  attr_reader :start_date, :end_date

  def initialize(period)
    splited = period.split
    @start_date = Date.parse(splited.first)
    @end_date = Date.parse(splited.last)
  end
end