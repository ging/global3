AvatarsForRails.setup do |config|
  config.avatarable_model = :actor
  config.current_avatarable_object = :current_actor
  config.avatarable_filters = [:authenticate_user!]
  config.avatarable_styles = { :representation => "20x20>",
                               :contact        => "30x30>",
                               :actor          => '35x35>',
                               :profile        => '119x119'}
end
