class WebhookJob < ApplicationJob
  queue_as :default

  def perform(webhook)

    puts "New Webhook: #{webhook.inspect}"
  end
end
