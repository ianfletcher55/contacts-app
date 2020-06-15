class Contact < ApplicationRecord

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/

  def friendly_created_at
    created_at.strftime("%b %e, %l:%M %p")
  end

  def friendly_updated_at
    updated_at.strftime("%b %e, %l:%M %p")
  end

  def full_name
    result = "#{first_name} #{last_name}"
    result
  end

  def country_code
    result = "+81 #{phone_number}"
    result
  end

  def address
    Geocoder.search([latitude, longitude]).first.address
  end

  def group_names
    groups.map { |group| group.name }
  end

  belongs_to :user
  has_many :contact_groups
  has_many :groups, through: :contact_groups

end
