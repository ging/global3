SocialStream.require_model 'group'

class Group
  def logo
    "spaces/#{ id % 5 + 1 }.png"
  end
end
