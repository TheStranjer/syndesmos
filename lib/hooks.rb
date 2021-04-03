class Syndesmos
  def add_hook(type, object, meth=nil)
    hooks[type] = [] if hooks[type].nil?

    hooks[type].push({ :object => object, :method => meth ? meth : type})
  end

  def clear_hooks(type)
    hooks[type] = []
  end

  private

  attr_accessor :last_notification_id

  def execute_hooks
    while true
      handle_notifications if hooks[:notification] and hooks[:notification].length > 0
      sleep hooks.values.flatten.length > 0 ? 60 : 1
    end
  end

  def handle_notifications
    self.last_notification_id = notifications({ "with_muted" => true, "limit" => 20 }).collect { |notif| notif['id'].to_i }.max if self.last_notification_id.nil?

    notifications({ "with_muted" => true, "limit" => 20, "since_id" => self.last_notification_id }).each do |notif|
      self.last_notification_id = notif['id'].to_i if notif['id'].to_i > self.last_notification_id
      hooks[:notification].each do |hook|
        hook[:object].send(hook[:method], notif)
      end
    end
  end
end