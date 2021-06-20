# AQIIndex
This is an iOS sample app for displaying AQI indexes of different cities.

Screenshots: 
![Simulator Screen Shot - iPod touch (7th generation) - 2021-06-20 at 14 12 30](https://user-images.githubusercontent.com/5212286/122673710-5a75f180-d1ef-11eb-891e-99e2ea06ae90.png)

![Simulator Screen Shot - iPhone 12 - 2021-06-20 at 17 45 27](https://user-images.githubusercontent.com/5212286/122673715-61046900-d1ef-11eb-91c9-aae9f9421f52.png)


![Simulator Screen Shot - iPhone 12 - 2021-06-20 at 17 45 33](https://user-images.githubusercontent.com/5212286/122673719-65308680-d1ef-11eb-9292-c65497098a35.png)


URL : "ws://city-ws.herokuapp.com"

Architecture Used : VIPER

Classes and Responsibilities
1. App Builder task - The responsibility of this class is to build the objects and all the dependencies of controller. 
2. App Router - This class is responsibile for routing between the views in class. Right now it only handles routing to detail controller but it can increase in future. 
3. AQIViewController - This is the viewcontroller which shows list of all the cities coming via websocket and display AQI and last updated time for them. 
4. AQIPresenter - Responsible for communicating between viewcontroller and interactor. Taking decisions like refreshing table when data is recieved. Making decisions like how many cells to be displayed, what data to be displayed in which row.
5. AQIInteractor - Responsible for communicating with WebSocketTask to start listening to socket, and then pass the data to presenter. In case we add a layer of database of any other storage, then interactor will also communicate and fetch data from that layer. 
6. CityAQITableCell - This is the table cell which displays the information related to city and AQI index.
7. AQIDetailController - This is the viewcontroller responsible for displaying data on detail vc including bar chat for only latest 5 aqi's.
8. AQIDetailPresenter - This is responsible for creating the content for bar in bar chat and other ui based decision for AQIDetailController.
9. ColorUtil - responsible for converting aqi in colors

Library used : [SwiftCharts](https://github.com/i-schuetz/SwiftCharts)

Dependency Manager Used: Cocoapods


Starting Time : Started around 2pm on sunday 20 June. 
Ending Time: 5:59 pm Sunday 20 June
