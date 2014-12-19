# encoding: utf-8
class Project < ActiveRecord::Base

  extend CarrierWave::Mount
  attr_accessor :image
  mount_uploader :image, ImageUploader

  require 'geocoder'

  def geolocate
    result_array = Geocoder.search( self.address )
    if result_array.any?
      self.lng_lat = result_array[0].coordinates.join ","
      unless self.lng_lat==","
        self.save
      else
        puts "ERROR! #{self}"
      end
    end
  end

  require 'rdiscount'
  def js_arr
    return nil if self.lng_lat.nil? or self.title.nil?
    self.title.gsub!(/'/,"´")
    self.body.gsub!(/'/,"´")
    header,rubrik = self.body.split("__")
    lng, lat = self.lng_lat.split(",")
    img = self.image_url rescue ''
    "{  title: '%s',
        header: '%s',
        image: '%s',
        rubrik: '%s',
        links: '%s',
        amount: '%s',
        lat: %s,
        lng: %s,
        marker: null
     }," % [self.title, RDiscount.new(header).to_html.strip, img, RDiscount.new(rubrik).to_html.strip, RDiscount.new(self.links).to_html.strip, RDiscount.new(self.amount).to_html.strip, lng, lat]
  end

  def load_from_json file_name
    JSON.parse(get_file_as_string(file_name)).each do |item|
      Customer.create(item)
    end
  end

  def get_file_as_string(filename)
    data = ''
    f = File.open(filename, "r")
    f.each_line do |line|
      data += line
    end
    return data
  end


end
