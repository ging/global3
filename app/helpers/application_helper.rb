module ApplicationHelper
  def show_simple_captcha(options)
    # Replace with a newer captcha plugin
    # See: http://ruby-toolbox.com/categories/rails_captcha.html
    ""
  end

  def current_tie 
    # Change with tie list
    current_user.
      sent_ties.
      received_by(@user || @space || current_user).
      where(:relation_id => Relation.mode('User', 'User').find_by_name("public")).first
  end
end
