# Analytics4Evo beta 0.1
Google Analytics for Evolution CMS

The package includes:

* **Analytics4Evo** Module: site Analytics reports overview
* **PageAnalytics4Evo** Plugin: resource/page Analytics reports
* **DashboardAnalytics4Evo** Plugin: Dashboard widget **(require evo 1.3/1.4)**

NOTE 1 : this package is developed for Evolution cms 1.3/1.4
To work with 1.2 release you need to set to "modxevo" the "cms" option in module and plugin settings.

NOTE 2 : this package use **Google Sign-In**. 
Before users can view their account information on the Google Analytics web site, they must first log in to their Google Accounts

Actually, server-side authorization and OAuth 2.0 are not supported.

# DashboardAnalytics4Evo
![widget](https://user-images.githubusercontent.com/7342798/34579224-629bbd36-f188-11e7-8d9d-57c90b4aa110.png)

# Analytics4Evo Module
![module](https://user-images.githubusercontent.com/7342798/34579228-64e4837a-f188-11e7-8717-3d8cf15d8f5c.png)

# PageAnalytics4Evo
![pageanalytics](https://user-images.githubusercontent.com/7342798/34579232-67087d00-f188-11e7-92f9-e2d82d2926cd.png)

## How to allow access to analytics from your site

1) go to https://console.developers.google.com/apis/credentials
2) select your project ID CLIENT
3) add your site url to the allowed javascript origins
4) if you have not already done, enable Analytics Api for your project (https://console.developers.google.com/apis/library)

## How to find your site property **ids** Table ID ?

1) goto to https://ga-dev-tools.appspot.com/account-explorer/
2) select account and property
3) copy the ids

# To Do

* better reponsive charts (maybe move to another chart library)
* server-side authorization / OAuth 2.0 (rewrite with php api (?))

