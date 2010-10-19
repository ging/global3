module TiesHelper

  def suggestion_link(subject)


  end

  
end



=begin
  <%= link_to "+ Add as contact",
              new_tie_path("tie[sender_id]" => current_user.actor.id,
                        "tie[receiver_id]" => user.actor.id,
                        "tie[relation_name]" => "friendship_request"),
              :class => 'boxy',
              :title => t('ask.add_friend', :name => user.name)
               %>

  <%= link_to "+ "+ t('follow'), new_tie_path("tie[receiver_id]" => space.actor.id,
                                                               "tie[relation_name]" => 'follower'),
                                                                :class => 'boxy',
                                                                :title => t('ask.add_follow', :name => space.name) %>
=end