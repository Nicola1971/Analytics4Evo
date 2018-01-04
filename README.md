# Analytics4Evo beta 0.1
Google Analytics for Evolution CMS

The package includes:

* **Analytics4Evo** Module: site Analytics reports overview
* **PageAnalytics4Evo** Plugin: resource/page Analytics reports

NOTE: this package is developed for Evolution cms 1.3/1.4
To work with 1.2 release you need to set to "modxevo" the "cms" option in module and plugin settings.

NOTE: this package use **Google Sign-In**. 
Before users can view their account information on the Google Analytics web site, they must first log in to their Google Accounts

Actually, server-side authorization and OAuth 2.0 are not supported.

## How to allow access to analytics from your site

1) go to https://console.developers.google.com/apis/credentials
2) select your project ID CLIENT
3) add your site url to the allowed javascript origins
4) if you have not already done, enable Analytics Api for your project (https://console.developers.google.com/apis/library)

## How to find your site property **ids** Table ID ?

1) goto to https://ga-dev-tools.appspot.com/account-explorer/
2) select account and property
3) copy the ids
