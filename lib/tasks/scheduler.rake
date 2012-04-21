desc "This task is called by the Heroku scheduler add-on and checks all of our events to see who to notify"
task :check_events do
    puts "Checking satellites and shit"
 #   Events.update_all
    puts "done."
end
