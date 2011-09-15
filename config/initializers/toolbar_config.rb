module SocialStream
  module ToolbarConfig
    #Prints the default home toolbar menu
    def default_home_toolbar_menu
      items = Array.new
      
      #Messages
      items << {:key => :messages,
        :name => image_tag("btn/new.png")+t('message.other')+' (' + current_subject.mailbox.inbox(:unread => true).count.to_s + ')',
        :url => "#",
        :options => {:link => {:id => "messages_menu"}},
        :items => [
          {:key => :message_new, :name => image_tag("btn/message_new.png")+ t('message.new'), :url => new_message_path, :options => {:link =>{:remote=> false}}},
          {:key => :message_inbox, :name => image_tag("btn/message_inbox.png")+t('message.inbox')+' (' + current_subject.mailbox.inbox(:unread => true).count.to_s + ')',
            :url => conversations_path, :options => {:link =>{:remote=> false}}},
          {:key => :message_sentbox, :name => image_tag("btn/message_sentbox.png")+t('message.sentbox'), :url => conversations_path(:box => :sentbox), :options => {:link =>{:remote=> false}}},
          {:key => :message_trash, :name => image_tag("btn/message_trash.png")+t('message.trash'), :url => conversations_path(:box => :trash)}
        ]}

      #Documents if present
      if SocialStream.activity_forms.include? :document
        items << {:key => :resources,
          :name => image_tag("btn/btn_resource.png",:class =>"menu_icon")+t('resource.mine'),
          :url => "#",
          :options => {:link => {:id => "resources_menu"}},
          :items => [
            {:key => :resources_events,:name => image_tag("btn/btn_event.png")+t('conference.title'),:url => events_path},
            {:key => :resources_documents,:name => image_tag("btn/btn_document.png")+t('document.title'),:url => documents_path},
            {:key => :resources_pictures,:name => image_tag("btn/btn_gallery.png")+t('picture.title'),:url => pictures_path},
            {:key => :resources_videos,:name => image_tag("btn/btn_video.png")+t('video.title'),:url => videos_path},
            {:key => :resources_audios,:name => image_tag("btn/btn_audio.png")+t('audio.title'),:url => audios_path}
          ]}
      end

      #Contacts
      items << {:key => :contacts,
        :name => image_tag("btn/btn_friend.png")+t('contact.other'),
        :url => "#",
        :options => {:link => {:id => "contacts_menu"}},
        :items => [
          {:key => :invitations, :name => image_tag("btn/btn_friend.png")+t('contact.current'), :url => contacts_path},
          {:key => :invitations, :name => image_tag("btn/btn_friend.png")+t('contact.pending.other'), :url => contacts_path(:pending=>true)},
          {:key => :invitations, :name => image_tag("btn/btn_invitation.png")+t('invitation.toolbar'), :url => new_invitation_path}
        ]}

      #Subjects
      items << {:key => :groups,
        :name => image_tag("btn/btn_group.png")+t('group.other'),
        :url => "#",
        :options => {:link => {:id => "groups_menu"}},
        :items => [{:key => :new_group ,:name => image_tag("btn/btn_group.png")+t('group.new.action'),:url => new_group_path('group' => { '_founder' => current_subject.slug })}]
      }

      render_items items
    end

    #Prints the default profile toolbar menu
    def default_profile_toolbar_menu(subject = current_subject)
      items = Array.new
      #Information button
      items << {:key => :subject_info,
        :name => image_tag("btn/btn_edit.png")+t('menu.information'),
        :url => [subject, :profile]
      }

      if subject!=current_subject
        #Like button
        items << {:key => :like_button,
          :name => link_like_params(subject)[0],
          :url => link_like_params(subject)[1],
          :options => {:link => link_like_params(subject)[2]}}

        if user_signed_in?
          #Relation button
          items << {:key => :subject_relation,
            :name => image_tag("btn/btn_friend.png") + current_subject.contact_to!(subject).status,
            :url => edit_contact_path(current_subject.contact_to!(subject))
          }
          #Send message button
          items << {:key => :send_message,
            :name => image_tag("btn/btn_send.png")+t('message.send'),
            :url => new_message_path(:receiver => subject.slug)
          }
        end
      end

      if SocialStream.activity_forms.include? :event and  subject.subject_type == 'Event'
        if !subject.agenda.nil?
        items << {:key => :outline_info,
          :name => image_tag("btn/btn_outline.png")+t('menu.outline'),
          :url =>  agenda_path(subject)
        }
        end
      end

      #Documents if present
      if SocialStream.activity_forms.include? :document
        if subject == current_subject
          resources_label = t('resource.mine')
        else
          resources_label = t('resource.title')
        end
        items << {:key => :resources,
          :name => image_tag("btn/btn_resource.png",:class =>"menu_icon")+resources_label,
          :url => "#",
          :options => {:link => {:id => "resources_menu"}},
          :items => [
            {:key => :resources_events,:name => image_tag("btn/btn_event.png")+t('conference.title'),:url => polymorphic_path([subject, Event.new])},
            {:key => :resources_documents,:name => image_tag("btn/btn_document.png")+t('document.title'),:url => polymorphic_path([subject, Document.new])},
            {:key => :resources_pictures,:name => image_tag("btn/btn_gallery.png")+t('picture.title'),:url => polymorphic_path([subject, Picture.new])},
            {:key => :resources_videos,:name => image_tag("btn/btn_video.png")+t('video.title'),:url => polymorphic_path([subject, Video.new])},
            {:key => :resources_audios,:name => image_tag("btn/btn_audio.png")+t('audio.title'),:url => polymorphic_path([subject, Audio.new])}
          ]}
      end
      render_items items
    end
  end
end
