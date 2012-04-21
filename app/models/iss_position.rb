class IssPosition
  require 'rest_client'

  def latitude
    iss_location["iss_position"]["latitude"]
  end

  def longitude
    iss_location["iss_position"]["longitude"]
  end

  private
  def iss_location
    @iss_location ||= JSON.parse(RestClient.get 'http://api.open-notify.org/iss-now/')
  end

end
