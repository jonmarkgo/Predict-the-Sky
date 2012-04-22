require 'hpricot'
require 'open-uri'
require 'time_diff'

#this code is somewhat awful
#but its the only way I found to get accurate data about when a satellite will actually be VISIBLE
#sorry for the ugliness, but hey, it works!

class IssEvent
  def self.scan_for_subscriber
    subscribers = Subscriber.where('latitude IS NOT NULL AND longitude IS NOT NULL')
    puts "Found #{subscribers.count} subscribers"

    if subscribers.count > 0
      @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
      subscribers.each do |subscriber|
        url = "http://www.heavens-above.com/PassSummary.aspx?satid=25544&Dur=1&lat="+subscriber.latitude.to_s+"&lng="+subscriber.longitude.to_s+"&tz="+subscriber.zone
        doc = Hpricot(open(url))

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

        alt = alt.gsub(/\D/, "")

        Time.zone = subscriber.zone
        t = Time.zone.now
        iss_time = Time.parse(date + ' ' + start_time)
        time_diff = Time.diff(iss_time, t)

        if (time_diff[:year] == 0 and time_diff[:month] == 0 and time_diff[:week] == 0 and time_diff[:day] == 0 and time_diff[:hour] == 0 and time_diff[:minute] < 9)
          puts 'Sending SMS to ' + subscriber.phonenumber + ' about the ISS'

          @client.account.sms.messages.create(
            :from => ENV['TWILIO_FROM_NUMBER'],
            :to => subscriber.phonenumber,
            :body => 'The International Space Station will pass overhead in ' + time_diff[:minute].to_s + ' minutes in the direction ' + az + ' at about ' + alt + ' degrees, go check it out!'
          )
        end
      end
    end
  end
end
