//
//  Scraper.swift
//  UIUCDiningHallScraper
//
//  Created by Xiangbin Hu on 8/19/17.
//
//

import Foundation
import Kanna
import Alamofire

public class Scraper {
    let diningHallToLocations = ["Busey-Evans" : "Busey-Evans Serving",
                                 "FAR" : "FAR Serving",
                                 "Ikenberry" : "Don's Chophouse Serving, Gregory Drive Diner Serving, Hortensia's Serving, Penne Lane Serving, Prairie Fire Serving, Soytainly Serving, Euclid Street Deli Serving, Baked Expectations Serving, Better Burger IKE Serving, Neo Soul Serving",
                                 "ISR" : "ISR Serving",
                                 "LAR" : "LAR Serving",
                                 "PAR" : "Abbondante Serving, Arugula's Serving, La Avenida Serving, Panini Bar, Provolone Serving, Sky Garden Serving, Better Burger Serving"]
    let diningUrl = URL(string: "http://www.housing.illinois.edu/Dining/Menus/Dining-Halls")
    let dateFormatter = DateFormatter()
    init() {
        dateFormatter.dateFormat = "MM/dd/yyyy"
    }
    
    
    /**
        - Parameters:
            - date: date of the data
            - diningHall: name of the dining Hall
            - successHandler: handler if we get the data successfully
            - failHandler: handler if we failed to get the data
     */
    public func getData(date: Date, diningHall: String,
                        successHandler: @escaping ([[String:NSObject]]) -> (),
                        failHandler: @escaping (Error) -> ()) {
        Alamofire.request(diningUrl!, method: .post, parameters: [:])
            .validate()
            .responseData { response in
                switch response.result {
                case .success:
                    let params = self.getParams(previousDoc: HTML(html: response.data!, encoding: .utf8)!, date: date, diningHall: diningHall)
                    
                    Alamofire.request(self.diningUrl!, method: .post, parameters: params)
                    .validate()
                    .responseData { response in
                        switch response.result {
                        case .success:
                            successHandler(self.getDetails(responseBody: response.data!))
                        case .failure(let error):
                            failHandler(error)
                        }
                    }
                case .failure(let error):
                    failHandler(error)
                }
                
        }

        
    }

    private func getDetails(responseBody: Data) -> [[String:NSObject]]{
        
        if let doc = HTML(html: responseBody, encoding: .utf8) {
            var details = [[String:NSObject]]()
            
            doc.xpath("//div[@class='ServingUnitMenu']")
                .forEach({ body in
                    
                    let diningserviceunit = body.at_xpath("h3")?.text!
                    
                    
                    body.xpath("//div[@class='MealPeriodMenu']").forEach({ body in
                        var mealPeriodMenu = [String:NSObject]()
                        mealPeriodMenu["DiningServiceUnit"] = diningserviceunit! as NSObject
                        mealPeriodMenu["DiningMealPeriod"] = body.at_xpath(".//h4")?.text! as! NSObject
                        
                        var food = [String:NSObject]()
                        var foodContent = [[String]]()
                        for element in body.xpath(".//text()[preceding-sibling::strong and following-sibling::br]") {
                            let text = element.text
                            let trimmedText = text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                            if trimmedText != nil && trimmedText != "" {
                                let splitedText = trimmedText?.components(separatedBy: ",")
                                var splitedTrimmedText = [String]()
                                splitedText?.forEach({body in
                                    splitedTrimmedText.append(body.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
                                })
                                
                                foodContent.append(splitedTrimmedText)
                            }
                            
                        }
                        var counter = 0
                        for element in body.xpath(".//*") {
                            
                            if element.tagName != "strong" {
                                continue
                            }
                            food[element.text!] = foodContent[counter] as NSObject
                            counter += 1
                            
                            
                        }
                        mealPeriodMenu["food"] = food as NSObject
                        details.append(mealPeriodMenu)
                
                    })
                })
            return details
            
        }
    return []
    }
    
    private func getParams(previousDoc: HTMLDocument, date: Date, diningHall: String) -> [String:String] {
        var dict = [String:String]()
        getASPNecessaryJunkParams(previousDoc: previousDoc, dict: &dict)
        dict["pagebody_0$txtServingDate"] = dateFormatter.string(from: date)
        dict["pagebody_0$ddlLocations"] = diningHallToLocations[diningHall]
        dict["pagebody_0$btnSubmit"] = "Select"
        return dict
    }
    
    private func getASPNecessaryJunkParams(previousDoc: HTMLDocument, dict: inout [String:String]) {

        dict["__VIEWSTATE"] = previousDoc.at_xpath("//input[@id='__VIEWSTATE']")?["value"]
        dict["__VIEWSTATEGENERATOR"] = previousDoc.at_xpath("//input[@id='__VIEWSTATEGENERATOR']")?["value"]
        dict["__EVENTVALIDATION"] = previousDoc.at_xpath("//input[@id='__EVENTVALIDATION']")?["value"]
        
    }
    
    
}
