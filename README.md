MyTweeter - A Twitter Client for the iPhone
===========================================

This Twitter client interfaces with the Twitter API in order to retrieve and send tweets on the logged in user's behalf via HTTP. 
There are four main views: contacts, tweets, web and map. The contacts view is simply an alphabetical listing of the followed users whose tweets were retrieved by the home_timeline request. These users are displayed in rows of a table view--selecting one will push that user's tweets into an additional tweet view. The recents view just displays the last 50 or more tweets retrieved by HTTP in decreasing chronological order. If a single tweet is clicked and that tweet has a link in it's text, the program will extract the link and push a new web view of that web page, fitted with back and forward navigation buttons. In addition, there is a map view, which displays a pin for all the user's contacts that have some associated location. The program uses geocoding to find specific coordinates for a location, then places a pin on the map at that location. If the pin is clicked, a callout view displays, which when clicked will push that user's tweets to the page.
Finally, an additional color picker view will allow the user to select a background color for all views using the hue saturation brightness (HSB) model.


