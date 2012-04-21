require 'hpricot'
require 'open-uri'
# require 'placefinder'


class IssEvent < Event
  def self.scan_for_subscriber
    subscribers = Subscriber.where('latitude IS NOT NULL AND longitude IS NOT NULL')
    puts "Found #{subscribers.count} subscribers"

    if subscribers.count > 0
      @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
      subscribers.each do |subscriber|
  puts"NEW SUBSCRIBER"
  #      latlng =  subscriber.latitude.to_s + ',' + subscriber.longitude.to_s
  #          placefinder = Placefinder::Base.new(:api_key => 'dj0yJmk9eWhETThSSW81WUJFJmQ9WVdrOVdFWk9RV3N6TkdFbWNHbzlNakV5TVRRM016TTJNZy0tJnM9Y29uc3VtZXJzZWNyZXQmeD1kNw--')
 # placeresult =  placefinder.get :q => latlng, :flags => 'TJ', :gflags => 'R'
 # Time.zone = placeresult['ResultSet']['Results'][0]['timezone']
 # t=  Time.zone.now
 #puts t.zone
 #puts ActiveSupport::TimeZone::MAPPING.find{|z| z == placeresult['ResultSet']['Results'][0]['timezone']}.tzinfo.current_period.abbreviation.to_s
   # puts placeresult['ResultSet']['Results'][0]['timezone'].to_json
   #puts "http://www.heavens-above.com/PassSummary.aspx?satid=25544&lat="+subscriber.latitude.to_s+"&lng="+subscriber.longitude.to_s+"&tz="+t.zone
        doc = Hpricot(open("http://www.heavens-above.com/PassSummary.aspx?satid=25544&lat="+subscriber.latitude.to_s+"&lng="+subscriber.longitude.to_s+"&tz=GMT"))
  puts      doc.search('table.standardTable').at('tr.lightrow').search('td').at('a').inner_html
        # do |stuff|
   #puts stuff.at('a').inner_html
 #end
        # change the CSS class on list element ul
    #    (doc/"ul.site-nav").set("class", "new-site-nav")
        #  remove the header
     #   (doc/"#header").remove
        # print the altered HTML
      #  puts doc

       # http://www.heavens-above.com/PassSummary.aspx?satid=25544&lat=40.73503&lng=-73.99159
       # @client.account.sms.messages.create(
       #   :from => '+14155992671',
      #    :to => subscriber.phonenumber,
      #    :body => 'The Internation Space Station will pass overhead soon, go outside and check it out! NOW!'
      #  )
      end
    end
  end
end
