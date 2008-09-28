class UserObserver < ActiveRecord::Observer
  # Only users atm are the blog admins which are manually created.  Worry about this later perhaps
  def after_create(user)
    # UserMailer.deliver_signup_notification(user)
  end

  def after_save(user)
    #UserMailer.deliver_activation(user) if user.recently_activated?
  end
end
