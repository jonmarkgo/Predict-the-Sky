Predict-the-Sky
===============

Predict the Sky SMS is a text message service for satellite enthusiasts. It tracks satellite events and sends you a SMS message when one is visible from your location on Earth as it's happening. Right now it tracks the ISS as it passes over the earth, as well as iridium flare events from a variety of satelites. It pulls the data from Heavens-Above.com and uses Twilio to send the text messages to subscribers.


## We now scrape http://www.heavens-above.com/ because it tells you when something will be actually visible ##

## Satellite List ##
http://www.n2yo.com/satellites/?c=1

## Subscribe Options ##
- Satellites (http://sscweb.gsfc.nasa.gov/WebServices/)
- ISS (http://open-notify.org/api-doc)
- Sunrise/sunset (https://github.com/mikereedell/sunrisesunset-ruby)
- Solar flares/storms
- Close planets
- Rocket launches
- comets/asteroids
- meteor shower
- aurorae
