class Location < ActiveRecord::Base
  attr_accessible :address, :latitude, :longitude

  # reverse_geocoded_by :latitude, :longitude, :address => :addresss
  geocoded_by :address
  after_validation :geocode
  # reverse_geocoded_by :latitude, :longitude
  #  after_validation :reverse_geocode  # auto-fetch address
  acts_as_gmappable
  def gmaps4rails_address
    address
  end

  def gmaps4rails_infowindow
     "<h4>#{address}</h4>"
  end



end
