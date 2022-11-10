class TourPresence
  attr_reader :tour, :current_user

  def initialize(tour, current_user)
    @tour = tour
    @current_user = current_user
  end

  def like?
    return false if current_user.blank?
    tour.users_tours.pluck(:user_id).include?(current_user.id)
  end
end