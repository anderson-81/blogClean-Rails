class Post < ActiveRecord::Base
  belongs_to :user

  has_attached_file :avatar, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage/
  validates_attachment_file_name :avatar, matches: [/png\z/, /jpe?g\z/]
  do_not_validate_attachment_file_type :avatar

  validates :title, presence: true
  validates :briefing, presence: true
  validates :text, presence: true
  validates :avatar, presence: true

  validates :title, length: { maximum: 100 }
  validates :briefing, length: { maximum: 200 }
  validates :text, length: { maximum: 3000 }
end
