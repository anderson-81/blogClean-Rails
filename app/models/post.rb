class Post < ActiveRecord::Base
  belongs_to :user

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  validates :title, presence: true
  validates :briefing, presence: true
  validates :text, presence: true
  validates :avatar, presence: true
end
