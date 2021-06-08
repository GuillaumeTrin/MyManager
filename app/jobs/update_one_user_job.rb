class UpdateOneUserJob < ApplicationJob
  queue_as :default

  def perform(user)
    UpdateOneUserFb.new(user).call
  end
end
