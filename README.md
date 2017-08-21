# UIUCDiningHallScraper

A scraper to scrape the dining hall menus in UIUC

## Install

### CocoaPod
```
pod 'UIUCDiningHallScraper', :git => "https://github.com/Xgbn/UIUCDiningHallScraper.git"
```

#### Note - libxml2
You need to add $(SDKROOT)/usr/include/libxml2 to Header Search Paths for the package to work

#### Note - security
IOS requires the following information to be added to Info.plist
```
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSExceptionDomains</key>
    <dict>
        <key>illinois.edu</key>
        <dict>
            <key>NSExceptionAllowsInsecureHTTPLoads</key>
            <true/>
            <key>NSIncludesSubdomains</key>
            <true/>
        </dict>
    </dict>
</dict>

```


## Usage

```swift
    let scraper = Scraper()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    let date = dateFormatter.date(from: "09/01/2017")
    let diningHall = "Ikenberry"
    scraper.getData(date: date!, diningHall: diningHall, successHandler: { data in
        print(data)
        },
        failHandler: { error in
            print(error)
        }
    )
```

## License
[MIT LICENSE](LICENSE)
