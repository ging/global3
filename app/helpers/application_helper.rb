module ApplicationHelper
  def show_simple_captcha(options)
    # Replace with a newer captcha plugin
    # See: http://ruby-toolbox.com/categories/rails_captcha.html
    ""
  end

  def current_tie
    receiver = @space || @user || current_user

    # Change with tie list
    current_user.
      sent_ties.
      received_by(receiver).
      where(:relation_id => Relation.mode('User', receiver.class.to_s).
        find_by_name("public")).first
  end
end
