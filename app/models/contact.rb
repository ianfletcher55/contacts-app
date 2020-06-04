class Contact < ApplicationRecord

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

end
