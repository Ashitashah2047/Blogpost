class DeleteExpiredPostJob < ApplicationJob
  queue_as :default

  def perform
    if Post.where(['end_date < ?', Time.now])
      Post.where('end_date < ?', Time.now).destroy_all
      sleep 2
    end
  end

end