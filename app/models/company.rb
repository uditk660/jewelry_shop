class Company < ApplicationRecord
  has_attached_file :logo,
    styles: {
      medium: "300x300>",
      thumb: "100x100>"
    },
    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :logo,
    content_type: /\Aimage\/.*\z/

  validates :name, presence: true
  validates :phone, presence: true
  validates :email, presence: true

  validates :gst, length: { is: 15 }, allow_blank: true
  validates :pan, length: { is: 10 }, allow_blank: true
  validates :adhaar, length: { is: 12 }, allow_blank: true
end