# UIUCDiningHallScraper

A scraper to scrape the dining hall menus in UIUC

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
