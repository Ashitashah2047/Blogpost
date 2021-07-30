class Post < ApplicationRecord

  has_many :comments, dependent: :destroy
  has_many :users, through: :comments

  belongs_to :user  

  def self.title(title)
    where("LOWER(title) LIKE :title", title: "%#{title.downcase}%")
  end

  def self.body(body)
    where("LOWER(body) LIKE :body", body: "%#{body.downcase}%")
  end

  def self.start_date(start_date)
    where("cast(start_date as text) LIKE :start_date", start_date: "%#{start_date.downcase}%")
  end

  def self.end_date(end_date)
    where("cast(end_date as text) LIKE :end_date", end_date: "%#{end_date.downcase}%")
  end

  validate :end_date_after_start_date?

  scope :expired_post, -> { where('end_date < ?', Date.current) }
  after_save_commit :delete_expired_post

  def delete_expired_post
    DeleteExpiredPostJob.perform_later
  end

  def end_date_after_start_date?
    if end_date < start_date
      errors.add :end_date, 'Must be after the Start Date'
    end
  end

  mount_uploader :image, ImageUploader
  validates :image, file_size: {less_than: 5.megabytes}

end
