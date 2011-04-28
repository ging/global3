
AvatarsForRails.setup do |config|
  config.avatarable_model = :actor
  config.current_avatarable_object = :current_subject
end


=begin
module AvatarsForRails::AvatarsControllerConfig
  def current_avatarable_object
    return current_subject
  end
end
=end