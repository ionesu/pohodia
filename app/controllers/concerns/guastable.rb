module Guastable
  def create_guest
    session[:guest_user_id] = save_guest.id
  end

  def save_guest
    user = User.create(email: SecureRandom.uuid, password: 'guest')
    user.skip_confirmation!
    user.save(validate: false)
    user
  end

  def guest_user
    User.find_by(id: session[:guest_user_id]) if session[:guest_user_id]
  end

  def guest?
    !!guest_user
  end

  def user_or_guest
    if current_user.present?
      current_user
    else
      if guest?
        guest_user
      else
        create_guest
        guest_user
      end
    end
  end
end