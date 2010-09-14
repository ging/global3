module ApplicationHelper
  def show_simple_captcha(options)
    # Replace with a newer captcha plugin
    # See: http://ruby-toolbox.com/categories/rails_captcha.html
    ""
  end

  def current_tie
    # Change with tie list
    current_user.
      ties.
      received_by(current_user).
      where(:relation_id => Relation.mode('User', 'User').find_by_name("Public")).first
  end
end
