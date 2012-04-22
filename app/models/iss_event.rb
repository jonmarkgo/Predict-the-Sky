require 'hpricot'
require 'open-uri'
require 'placefinder'
require 'time_diff'


class IssEvent < Event
  def self.scan_for_subscriber
    subscribers = Subscriber.where('latitude IS NOT NULL AND longitude IS NOT NULL')
    puts "Found #{subscribers.count} subscribers"

    if subscribers.count > 0
      @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
      subscribers.each do |subscriber|
        latlng =  subscriber.latitude.to_s + ',' + subscriber.longitude.to_s
        placefinder = Placefinder::Base.new(:api_key => 'dj0yJmk9eWhETThSSW81WUJFJmQ9WVdrOVdFWk9RV3N6TkdFbWNHbzlNakV5TVRRM016TTJNZy0tJnM9Y29uc3VtZXJzZWNyZXQmeD1kNw--')
        placeresult =  placefinder.get :q => latlng, :flags => 'TJ', :gflags => 'R'
        Time.zone = placeresult['ResultSet']['Results'][0]['timezone']
        t = Time.zone.now
        zone = t.zone
        if (zone == 'EEST')
          zone = 'RFTm2'
        end
        begin
          doc = Hpricot(open("http://www.heavens-above.com/PassSummary.aspx?satid=25544&lat="+subscriber.latitude.to_s+"&lng="+subscriber.longitude.to_s+"&tz="+zone))
        rescue Exception => e
          doc = Hpricot(open("http://www.heavens-above.com/PassSummary.aspx?satid=25544&lat="+subscriber.latitude.to_s+"&lng="+subscriber.longitude.to_s+"&tz=GMT"))
        end

        count = 1
        start_time = alt = az = date = ''
        doc.search('table.standardTable').at('tr.lightrow').search('td') do | col |
          if (count == 1)
            date = col.at('a').inner_html
          elsif (count == 3)
            start_time = col.inner_html
          elsif (count == 4)
            alt = col.inner_html
          elsif (count == 5)
            az = col.inner_html
          end
          count = count + 1
        end
        iss_time = Time.parse(date + ' ' + start_time)

        time_diff = Time.diff(iss_time, t)

        if (time_diff[:year] == 0 and time_diff[:month] == 0 and time_diff[:week] == 0 and time_diff[:day] == 0 and time_diff[:hour] == 0 and time_diff[:minute] > 20)
          puts 'Sending SMS to ' + subscriber.phonenumber + ' about the ISS'
      
          @client.account.sms.messages.create(
            :from => '+14155992671',
            :to => subscriber.phonenumber,
            :body => 'The International Space Station will pass overhead in ' + time_diff[:minute] + ' minutes in the direction ' + az + ' at about ' + alt + ' degrees, go check it out!'
          )
        end
      end
    end
  end
end
