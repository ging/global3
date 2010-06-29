module ApplicationHelper
  def show_simple_captcha(options)
    # Replace with a newer captcha plugin
    # See: http://ruby-toolbox.com/categories/rails_captcha.html
    ""
  end

  def current_contact
    # Change with contact list
    current_user.
      contacts.
      actor_to(current_user).
      where(:role_id => Role["Public"].id).first
  end
end
