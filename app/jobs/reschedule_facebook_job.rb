class RescheduleFacebookJob < ApplicationJob
  queue_as :default

  def perform(post)
    # Do something later
    job = Sidekiq::ScheduledSet.new.find_job(post.job_id)
    job&.reschedule(post.published_at)
    
  end
end
