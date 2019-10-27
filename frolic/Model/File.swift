//
//  File.swift
//  frolic
//
//  Created by Huda T on 10/26/19.
//  Copyright © 2019 adventurers. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import LyftSDK
import CoreLocation

class eventbriteHandler {

    //-----KEY------
    let key = "token=ZYFPUYLPXW6SGOSVFTNB" //append the key

    //-----URLS------
    let sampleURL = "https://www.eventbriteapi.com/v3/events/search/?start_date.keyword=this_week&token=ZYFPUYLPXW6SGOSVFTNB"

    //------API REQUEST----
    public func getEvents(completionHandler:@escaping (String?) -> Void) {
        let all_event_categories = "https://www.eventbriteapi.com/v3/categories/?" + key
        Alamofire.request(all_event_categories, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                let ebJSON : JSON = JSON(response.result.value!)
                completionHandler(ebJSON["locale"].string!)
            }
        }
    }
}

/*
    Example body code for button that prints out duration
        let handler = googleHandler()
        handler.getTravelTime(travelMode: "driving", origin: "Powder Springs Georgia", destination: "Atlanta, Georgia") { duration in print(duration!)}
        
    Example body code for geocode button
        let handler = googleHandler()
        handler.geocode(location: "Atlanta, Georgia") {tup in
            print(tup!.0)
            print(tup!.1)
        }
    }
*/

class googleHandler {

    //-----KEY------
    let key = "AIzaSyDOcvJbQYUYZVoOOGCKCTC5djD0nQ4-qOU"

    func getTravelTime(travelMode: String, origin: String, destination: String, completionHandler:@escaping (String?) -> Void) {
        let travel_mode : String = "mode=" + travelMode;
        let destinationsArg = "destinations=" + String(destination.map {$0 == " " ? "+" : $0});
        let originsArg = "origins=" + String(origin.map {$0 == " " ? "+" : $0});
        let queryString = "https://maps.googleapis.com/maps/api/distancematrix/json?"
            + originsArg + "&" + destinationsArg + "&" + travel_mode + "&key=" + key

        Alamofire.request(queryString, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                let googleMapJSON : JSON = JSON(response.result.value!)
                completionHandler(googleMapJSON["rows"][0]["elements"][0]["duration"]["text"].string!)
            }
        }
    }

    // public func findPlace(_ type : String) {
    //     let location_type = "input=" + String(type.map {$0 == " " ? "%20" : $0})
    //     let location_bias = "&locationbias=circle:2000@47.6918452,-122.2226413"
    //     queryString: String = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=" + location_type
    //         + " &inputtype=textquery&fields=formatted_address,name,opening_hours,rating&key=" + key;
    //     let places : Set = [""]
    // }

    // public func getAutocomplete() {
        // when users typed in locations, they could autopopulate with possiblea answers
//    // }
//
    public func geocode(location: String, completionHandler:@escaping ((Double, Double)?) -> Void) {
        let replaced = String(location.map {$0 == " " ? "+" : $0});
        let queryString : String = "https://maps.googleapis.com/maps/api/geocode/json?address=" + replaced + "&key=" + key
        Alamofire.request(queryString, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                let geocodeJSON :JSON = JSON(response.result.value!)
                let pair :JSON = geocodeJSON["results"][0]["geometry"]["location"]
                let latitude :Double = pair["lat"].doubleValue
                let longitude :Double = pair["lng"].doubleValue
                completionHandler((latitude, longitude))
            }
        }
    }

    public func ungeocode(latitude: Double, longitude: Double, completionHandler:@escaping (String?) -> Void) {
        let query1 = "https://maps.googleapis.com/maps/api/geocode/json?latlng="
        let query2 = String(latitude) + "," + String(longitude) + "&key=" + key
        let queryString = query1 + query2

        Alamofire.request(queryString, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                let ungeocodeJSON : JSON = JSON(response.result.value!)
                let address = ungeocodeJSON["results"][1]["formatted_address"].string!
                completionHandler(address)
            }
        }
    }
}

/*
    HOW TO CALL THE GETCOSTS method from ViewController
    let handler = lyftHandler()
    handler.getCosts(pickup: "Klaus Advanced Computing Building Atlanta Georgia", dropoff: "5554 cathers creek drive powder springs ga") {
            cost in print(cost)
    }
*/

class lyftHandler {
    public func getCosts(pickup : String, dropoff : String, completionHandler:@escaping (Double) -> Void) {
        let handler = googleHandler()
        handler.geocode(location: pickup) {
            start in
            handler.geocode(location: dropoff) {
                dest in
                let pickup = CLLocationCoordinate2D(latitude: start!.0, longitude: start!.1)
                let destination = CLLocationCoordinate2D(latitude: dest!.0, longitude: dest!.1)
                var amt :Double = 0
                var count :Int = 0
                LyftAPI.costEstimates(from: pickup, to: destination, rideKind: .Standard) { result in
                    result.value?.forEach { costEstimate in
                        amt += Double(truncating: costEstimate.estimate!.minEstimate.amount as NSNumber)
                        amt += Double(truncating: costEstimate.estimate!.maxEstimate.amount as NSNumber)
                        count += 1
                    }
                    completionHandler(amt / Double(2 * count))
                }
            }
        }
    }
}
