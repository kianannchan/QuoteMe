# QuoteMe

*QuoteMe is a personalised inspiration collections that is developed using HTML5, Bootstrap 4.5 and [Dart](https://dart.dev/) Programming Language.*
>Dart is a client-optimized programming language for apps on multiple platforms. 
>It is developed by Google and is used to build mobile, desktop, server, and web applications. 
>Dart is an object-oriented, class-based, garbage-collected language with C-style syntax. 
>Dart can compile to either native code or JavaScript.
#
### Features
- [x] Pre-loading Page
- [x] Fetch Random Quote from Rest API server
- [x] Open Quote in interval. Basic account interval is 10 (sec).
- [x] Add Quote to Favourite. Basic account favorite quota is 10.
- [x] Remove Favourite Quote 

#
### Software Model
```
Main (View) -> Controller/ Model (Config)
Main (View) -> Controller/ Model (Quote)
```

*Controller/ Model (Config)*
```
- int _base_upload_limit;
- bool _premium;
- String _account_id;
- int _interval;
- int _upload_limit;
- bool _isStopped;
- DateTime _captureTime;
- List <Map> _collection;
+ int getBaseUploadLimit();
+ bool getPremiumStatus();
+ String getAccountId();
+ int getInterval();
+ int getUploadLimit();
+ bool getTimerStatus();
+ DateTime getCaptureTime();
+ List getFavQuote();
+ void setPremiumStatus(bool);
+ void setAccountId(String);
+ void setInterval(int);
+ void setUploadLimit(int);
+ void setTimerStatus(bool);
+ void setCaptureTime (DateTime);
+ void setFavQuote(String)
+ bool verifyFavQuota(String);
+ void removeFavQuote(String);
```

*Controller/ Model (Quote)*
```
- String _id;
- String _tags;
- String _content;
- String _author;
+ Future fetchQuote();
+ Map <String, dynamic> toJson();
+ Quote fromJson(Map);
+ String getId();
+ String getTags();
+ String getContent();
+ String getAuthor()
```

*Main (View)*
```
+ void setInterval();
+ void updateContent(int);
+ void displayToast(String, String);
+ void updateFav(String, String, String);
+ void updateFavProgress();
```
#
### Screenshot
![preloading page](https://i.ibb.co/gzVWc6t/loading.png)

*Page will render preloading page, while waiting for page to complete loading*

![Landing page](https://i.ibb.co/svfRxfv/landing.png)

*Landing Page of the software, that toggle the quote fetching, number of favourites 
quote left, list of favourite quotes and removing of quotes.* 

![Quote render](https://i.ibb.co/XDFRPYz/quote-Render.png)

*Quote fetch from API and rendered on the modal before opening it*

![Toast Notification](https://i.ibb.co/CKz08G4/added.png)

*Toast notification of the status of added quotes to favourite 
reflected at the bottom right of the software.*

#
### Development
- [ ] Database support
- [ ] Upload limit
- [ ] Interval limit
- [ ] Graphic design customisation of cards
- [ ] Share to social media
