//
//  ScraperTests.swift
//  UIUCDiningHallScraper
//
//  Created by Xiangbin Hu on 8/19/17.
//
//

import Foundation
import XCTest
@testable import UIUCDiningHallScraper

class ScraperTests: XCTestCase {
    
  
    
    func testGetData() {
        let expect = expectation(description: "finish call back")
        let scraper = Scraper()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let date = dateFormatter.date(from: "09/01/2017")
        let diningHall = "Ikenberry"
        scraper.getData(date: date!, diningHall: diningHall, successHandler: { data in
            print(data)
            
            XCTAssertNotNil(data)
            
            expect.fulfill()
            },
            failHandler: { error in
                print(error)
            }
        )
        waitForExpectations(timeout: 2)
        

    }
}
