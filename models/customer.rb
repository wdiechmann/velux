# encoding: utf-8
class Customer < ActiveRecord::Base
  

  def self.import_file name
    f = File.open name if File.exist? name
    lines = f.readlines
    f.close
    customer = nil
    # Navn:  8 Teen
    # E­mail: heidi.meldgaard@hotmail.com
    # Adresse: v/Heidi Meldgaard Rosenholmvej 18, 8543 Hornslet
    # 86995900 8 Teen 86995900
    lines.each do |line|
      case line
      when /Navn\:/
        customer.save if customer.class==Customer
        customer = Customer.new name: line.gsub(/Navn: *(.*)\n/i,'\1')

      when /email\:/i
        customer.email = line.gsub(/Email: *(.*)\n/i,'\1')

      when /Adresse\:/i
        next if customer.nil?
        if customer.class==Customer && !customer.street.nil?
          customer.save 
          customer = customer.dup
        end
        zipcity = line.gsub(/^.*Adresse: *(.*)\n/i,'\1').split ","
        customer.street = zipcity[0] if zipcity.size > 0
        customer.zip_city = zipcity[1] if zipcity.size > 1
        

      when /^\d{8} /
        customer.phone = line.split(" ")[0]

      end
      
    end
  rescue Exception => e
    puts e
    false
  end
  
  require 'geocoder'
  # Bad Boys & Bad Girls;Butik 372, plan 3, City 2, Danmark;Tåstrup;jeff,rebus boy, rebus girl
  def self.import_csv_file name
    f = File.open name if File.exist? name
    lines = f.readlines
    f.close
    customer = nil
    Customer.delete_all
    lines.each do |line|
      name,street,zip,city,country,contact,phone,email,brands = line.gsub(/^(.*)\n/i,'\1').split(";")
      customer = Customer.new name: name, street: street, zip_city: zip + '  ' + city, contact: contact, brands: brands, country: country, email: email, phone: phone
      customer.geolocate
      puts customer.name
      sleep 5
    end
    true
  rescue Exception => e
    puts e
    false
  end
  
  def self.geolocate(str)
    result_array = Geocoder.search( str )
    result_array.any? ? result_array[0].coordinates.join( ",") : "ingen geo position fundet ud fra '#{str}'"
  end
  
  def geolocate
    name = self.name=='FBInc' ? '' : self.name
    str = [ name.strip, self.street.strip, self.zip_city.strip, self.country.strip].join(",")
    result_array = Geocoder.search( str )
    if result_array.any?
      self.lng_lat = result_array[0].coordinates.join ","
      unless self.lng_lat==","
        self.save 
      else
        puts "ERROR! #{self}"
      end
    end
  end
  
  def js_arr
    return nil if self.lng_lat.nil? or self.name.nil?
    self.name.gsub!(/'/,"´")
    "{  name: '%s', 
        street: '%s', 
        zip_city: '%s', 
        country: '%s',
        contact: '%s',
        email: '%s',
        phone: '%s',
        lat: %s, 
        lng: %s, 
        marker: null
     }," % [self.name, self.street, self.zip_city, self.country, self.contact, self.email, self.phone, self.lng_lat.split(",")[0], self.lng_lat.split(",")[1]]
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