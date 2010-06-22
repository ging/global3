module PostHelper

  #Display the comments or an empty comment message
  def posts_display(_comments)
    html = content_tag(:div,
    _post.blank? ? "<h3>No comments currently available</h3>" : render(:partial => _post),:class => "post")
  end

  def new_post_link
    link_to 'Create a new post', new_post_path(),:class => "get"
  end
end