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
    let formatted_address :String;
    let price_level :Int
    let user_rating :Double
    let type :Type

    init(name :String, formatted_address :String,
        price_level :Int = -1, user_rating :Double, type :Type) {
            self.name = name
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
    let key = "token=ZYFPUYLPXW6SGOSVFTNB" //append the key
    let category_options :Array = ["Music", "Food & Drink", "Community & Culture", "Performing & Visual Arts", "Film, Media & Entertainment"]

    //-----URLS------
    let sampleURL = "https://www.eventbriteapi.com/v3/events/search/?start_date.keyword=this_week&location.address=georgia_tech&location.within=5mi&token=ZYFPUYLPXW6SGOSVFTNB"

    public func getEvent(address :String, radius :Int = 3, completionHandler:@escaping (Array<Event>?) -> Void) {
        let start_keyword :String = "this_week"
        let start_date = "&start_date.keyword=" + start_keyword  // ex, this_week
        let location_address = "&location.address=" + address
        let location_within = "&location.within=" + String(radius) + "mi"
        let location = location_address + location_within
        var event_query = "https://www.eventbriteapi.com/v3/events/search/?" + location + start_date + "&" + key
        
        event_query = "https://www.eventbriteapi.com/v3/events/search/?start_date.keyword=this_week&location.address=georgia_tech&location.within=5mi&token=ZYFPUYLPXW6SGOSVFTNB"

        Alamofire.request(event_query, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                let eventJSON : JSON = JSON(response.result.value!)
                let events :Array = eventJSON["events"].arrayValue
                var i :Int = 0
                var e :Event = Event(place: Place(name: "", formatted_address: "", price_level: -1, user_rating: -1, type: Type.ACTIVITY), time: (0,0))
                var arr :Array<Event> = Array<Event>()
                while (i < events.count) {
                    if (true) { // compare dates & times
                        let venue_query :String = "https://www.eventbriteapi.com/v3/venues/venue_id/" + events[i]["venue_id"].string!
                        Alamofire.request(venue_query, method: .get).responseJSON {
                            location in
                            if location.result.isSuccess {
                                let locationJSON : JSON = JSON(location.result.value!)
                                let address :String = locationJSON["address"]["address_1"].string!
                                let p :Place = Place(name: address, formatted_address: address, price_level: (events[i]["is_free"].boolValue ? 0 : 3),
                                    user_rating: -1, type: Type.ACTIVITY)
                                e = Event(place: p, time: (0,0))
                                arr.append(e)
                            }
                        }
                    }
                    i += 1
                }
                completionHandler(arr)
            } else {
                
                print("fail")
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

    public func findPlace(_ given_type :Type, _ detail :String = "", latitude :Double, longitude :Double, radius :Int = 2000, completionHandler: @escaping (Place?) -> Void) {
        var more_detail :String = detail
        switch given_type {
        case .MEAL:
            more_detail = detail + " " + meal_options.randomElement()!
        case .SNACK:
            more_detail = detail + " " + snack_options.randomElement()!
        case .ACTIVITY:
            more_detail = detail + " " + activity_options.randomElement()!
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
                    formatted_address: place["formatted_address"].string!,
                    price_level: place["price_level"].intValue,
                    user_rating: place["user_rating"].doubleValue,
                    type: given_type
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
