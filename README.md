# CS4261FirstProgrammingAssignment
Simple App created as a part of my first programming assignment for CS 4261

This app will allow you to create an account, log in to the same account, and then check the weather for any given US zip code while displaying the current device time. 

You will need to install relevant Firebase repositories when you open this in XCode to enable the login and sign-up features. This may require the user to create their Firebase account, firebase app, and allow Firebase authentication and Firestore

in WeatherPageViewContoller, to get current weather data, you need to create an API key from openweathermap.org and put it in the appropriate field.

For the history of users to be loaded in your Firestore and Firebase auth to run, you have to follow the steps to create an app in Firebase and import the following four packages when you reach the appropriate page:
- Set dependency rule as "Up to Next Minor Version"
- Select "FirebaseAuth"
- Select "FirebaseFirestore"
- Select "FirebaseFirestoreCombine-Community"
- Select "FirebaseFirestoreSwift"
- Click add package

If you are facing issues:
- Open the .xcworkspace file in the project directory to open it in Xcode
- Ensure the API key is added to WeatherPageViewContoller.swift
- Add your personal team to the application in Xcode if the build fails
- If Firebase errors occur, try removing and reinstalling the packages while ensuring you set up Firebase correctly
- If Firebase errors persist, click on the "redefinition of module Firebase" error and delete all the contents of the file.
- Firebase may require removing my personal GoogleService-Info file and replacing it with yours when you set up Firebase.
