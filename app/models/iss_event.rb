class IssEvent < Event
  def self.scan_for_subscriber
    position = IssPosition.new

    # find all users that live in the pass region
    subscribers = Subscriber.all #within(position.latitude, position.longitude)
    puts "Found #{subscribers.count} subscribers"

    if subscribers.count > 0
      @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
      subscribers.each do |subscriber|
        @client.account.sms.messages.create(
          :from => '+14155992671',
          :to => subscriber.phonenumber,
          :body => 'The Internation Space Station will pass overhead soon, go outside and check it out! NOW!'
        )
      end
    end
  end
end
