# MobileEvaluation
Qs. You are hired by FancyCars.ca. FancyCars.ca has asked you to build an App. In this app they want to:

Show list of all the cars and for each car, they want to show picture, name, make, model and availability of the car. 
Your app should support infinite scroll for the listing of the cars
Have a sort Dropdown which can sort the results by both the name and availability of the car
Show a buy button that only shows up if Availability is “In Dealership”
Make sure your app can also work when its offline

For this exercise, please build the app using either React Native, Kotlin, Java, Swift or Objective C. We prefer React Native if you can build app using it.

Assume that BE will expose two services - AvailabilityService to get availability of the cars and CarService to get list of all the cars. You can stub the API data in your App and don’t have to write the service.

API spec is as follows: 

GET /availability?id=123 
RESPONSE: {available: “In Dealership”}  // all  options are [ “Out of Stock”, “Unavailable”]

GET /cars
RESPONSE:  [ {id: 1, img: http://myfancycar/image, name: “My Fancy Car”, make: “MyMake”, model: “MyModel”, year: 2018} ….]
