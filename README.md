# Analytics4Evo RC1
Google Analytics for Evolution CMS
Module, Plugin and widget

**Important**: This package is based on [Google Analytics Embed API](https://ga-dev-tools.appspot.com/embed-api/) JavaScript library and use **Google Sign-In**. 

Before users can view their account information on the Google Analytics web site, they must first log in to their Google Accounts
Actually, server-side authorization and OAuth 2.0 are not supported.

![analytics4evo-logo](https://user-images.githubusercontent.com/7342798/34605431-e8a8a910-f20b-11e7-8cdc-786160c5e7fe.png)

## **Analytics4Evo** package includes:

* **Analytics4Evo** Module: site Analytics reports overview
* **PageAnalytics4Evo** Plugin: resource/page Analytics reports
* **DashboardAnalytics4Evo** Plugin: Dashboard widget **(require evo 1.3/1.4)**

![module-full](https://user-images.githubusercontent.com/7342798/34653635-1c6536ee-f3ef-11e7-8446-f60d38afcfee.png)

NOTE : this package is developed for Evolution cms 1.3/1.4
To work with 1.2 release you need to set to "modxevo" the "cms" option in module and plugin settings.





# DashboardAnalytics4Evo (dashboard widget)
![widget-rc1](https://user-images.githubusercontent.com/7342798/34653742-8f5d23a4-f3f0-11e7-9d7a-b85a5078cc4a.png)

# Analytics4Evo (module)
![mod](https://user-images.githubusercontent.com/7342798/34653642-2f822ef8-f3ef-11e7-9fd1-d01111565345.png)

# PageAnalytics4Evo (plugin)
![plugin](https://user-images.githubusercontent.com/7342798/34653651-4421d9d0-f3ef-11e7-882c-041ea99a7540.png)

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

* better responsive charts (maybe move to another chart library)
* server-side authorization / OAuth 2.0 (rewrite with php api (?))

