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

class Event {
   let place : Place
   let time : (Int, Int) // idk what this should look like

   init(place :Place, time :(Int, Int)) {
       self.place = place
       self.time = time
   }
}

class Place {
    let name :String
    let place_id :String
    let formatted_address :String;
    let price_level :Int
    let user_rating :Double
    let type: Type

    init(name :String, place_id :String, formatted_address :String,
         price_level :Int = -1, user_rating :Double, type: Type) {
            self.name = name
            self.place_id = place_id
            self.formatted_address = formatted_address
            self.price_level = price_level
            self.user_rating = user_rating
        self.type = type
        }
}

enum Type {
    case MEAL
    case SNACK
    case ACTIVITY
}

class eventbriteHandler {

    //-----KEY------
    let key = "token=NOT_FOR_YOUR_EYES" //append the key

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
    let key = "NOT_FOR_YOUR_EYES"
    let snack_options :Array = ["bakery", "cafe", "coffee shop", "boba"]
    let meal_options :Array = ["restaurant", "food", "point_of_interest", "establishment"]
    let activity_options :Array = ["amusement park", "aquarium", "art gallery", "bowling alley", "museum", "shopping mall", "tourist_attraction", "zoo"]

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

    public func findPlace(_ giventype :Type, _ detail :String="", latitude :Double, longitude :Double, radius :Int = 2000, completionHandler: @escaping (Place?) -> Void) {
        var more_detail :String = detail
        if (giventype == Type.MEAL) {
            more_detail += " " + meal_options.randomElement()!
        } else if (giventype == Type.SNACK) {
            more_detail += " " + snack_options.randomElement()!
        } else {
            more_detail += " " + activity_options.randomElement()!
        }
        let location_type :String = more_detail.replacingOccurrences(of: " ", with: "%20") + "%20"
        let circle :String = "circle:" + String(radius)
        let location :String = "@" + String(latitude) + "," + String(longitude)
        let location_bias = circle + location
        let fields_of_interest :String = "place_id,formatted_address,name,price_level,rating"
        let queryString :String = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=" + location_type
            + "&inputtype=textquery&fields=" + fields_of_interest + "&location_bias=" + location_bias + "&key=" + key;
        Alamofire.request(queryString, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                let placeJSON : JSON = JSON(response.result.value!)
                let place = placeJSON["candidates"][0]
                let place_obj :Place = Place(
                    name: place["name"].string!,
                    place_id: place["place_id"].string!,
                    formatted_address: place["formatted_address"].string!,
                    price_level: place["price_level"].intValue,
                    user_rating: place["user_rating"].double ?? -1,
                    type: giventype
                )
                completionHandler(place_obj)
            }
        }
    }

    // Place Details Request to get the actual hours of a place (beyond just "open-now")?

    // public func getAutocomplete() {
        // when users typed in locations, they could autopopulate with possiblea answers
    // }

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
    public func getCosts(pickup : String, dropoff : String, completionHandler:@escaping (Double, Int) -> Void) {
        let handler = googleHandler()
        handler.geocode(location: pickup) {
            start in
            handler.geocode(location: dropoff) {
                dest in
                let pickup = CLLocationCoordinate2D(latitude: start!.0, longitude: start!.1)
                let destination = CLLocationCoordinate2D(latitude: dest!.0, longitude: dest!.1)
                var amt :Double = 0
                var count :Int = 0
                var duration :Int = 0
                LyftAPI.costEstimates(from: pickup, to: destination, rideKind: .Standard) { result in
                    result.value?.forEach { costEstimate in
                        amt += Double(truncating: costEstimate.estimate!.minEstimate.amount as NSNumber)
                        amt += Double(truncating: costEstimate.estimate!.maxEstimate.amount as NSNumber)
                        duration += Int(truncating: costEstimate.estimate!.durationSeconds as NSNumber) / 60
                        count += 1
                    }
                    completionHandler(amt / Double(2 * count), duration)
                }
            }
        }
    }
}
