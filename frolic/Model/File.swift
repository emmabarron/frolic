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
    let eventbrite_key = "token=ZYFPUYLPXW6SGOSVFTNB" //append the key

    //-----URLS------
    let all_event_categories = "https://www.eventbriteapi.com/v3/categories/?token=ZYFPUYLPXW6SGOSVFTNB"
    let sampleURL = "https://www.eventbriteapi.com/v3/events/search/?start_date.keyword=this_week&token=ZYFPUYLPXW6SGOSVFTNB"

    //------API REQUEST----
    public func theFunc() {
        Alamofire.request(all_event_categories, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                //print("hello")
                let ebJSON : JSON = JSON(response.result.value!)
                //print(ebJSON["locale"])
                self.dealWithJSON(ebJSON)
            }
            else {
                print("didnt work")
            }
        }
    }

    //----ACCESSING JSON------
    func dealWithJSON(_ json: JSON) {
        let result = json["locale"]
        print(result)
    }
}

//class googleHandler {
//
//    //-----KEY------
//    let key = "AIzaSyBZxaCnQa-YCja2TMDp8rHg41PtUEV5IQo"
//
//    var travelTime : Int = 0
//    //let GMSPlacesClient.provideAPIKey(key)
//
////    func getTravelTime(travelMode : String, origin : String, destination : String) -> Int {
////        var travel_mode : String = "mode=" + travelMode;
////        let destinationsArg = "destinations=" + String(destination.map {$0 == " " ? "+" : $0});
////        var originsArg = "origins=" + String(origin.map {$0 == " " ? "+" : $0});
////        let queryString = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&"
////            + originsArg + "&" + destinationsArg + "&" + travel_mode + "&key=" + key
////        var duration : String
////
////        Alamofire.request(queryString, method: .get).responseJSON {
////            response in
////            if response.result.isSuccess {
////                let googleMapJSON : JSON = JSON(response.result.value!)
////                duration = googleMapJSON["rows"]["elements"]["duration"]["text"].string!
////                //print("durationSeconds \(duration / 60)")
////            } else {
////                print("getTravelTime didnt work")
////            }
////        }
////        return Int(duration)! / 60
////    }
//
//    func getTravelTime(travelMode : String, origin : String, destination : String) {
//        let travel_mode : String = "mode=" + travelMode;
//        let destinationsArg = "destinations=" + String(destination.map {$0 == " " ? "+" : $0});
//        let originsArg = "origins=" + String(origin.map {$0 == " " ? "+" : $0});
//        let queryString = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&"
//            + originsArg + "&" + destinationsArg + "&" + travel_mode + "&key=" + key
//
//        Alamofire.request(queryString, method: .get).responseJSON {
//            response in
//            if response.result.isSuccess {
//                let googleMapJSON : JSON = JSON(response.result.value!)
//                let duration : String = googleMapJSON["rows"]["elements"]["duration"]["text"].string!
//                //print("durationSeconds \(duration / 60)")
//                self.assignTravelTime(Int(duration)! / 60)
//            } else {
//                print("getTravelTime didnt work")
//            }
//        }
//        //return Int(duration)! / 60
//    }
//
//    func assignTravelTime(_ duration: Int) {
//        travelTime = duration
//    }
//
//    public func getTravelTime() -> Int {
//        return travelTime
//    }
//
//    // public func findPlace(_ type : String) {
//    //     let location_type = "input=" + String(type.map {$0 == " " ? "%20" : $0})
//    //     let location_bias = "&locationbias=circle:2000@47.6918452,-122.2226413"
//    //     queryString: String = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=" + location_type
//    //         + " &inputtype=textquery&fields=formatted_address,name,opening_hours,rating&key=" + key;
//    //     let places : Set = [""]
//    // }
//
//    // public func getAutocomplete() {
//        // when users typed in locations, they could autopopulate with possiblea answers
//    // }
//
////    public func geocode(location: String) -> (Double, Double) {
////        let replaced = String(location.map {$0 == " " ? "+" : $0});
////        var queryString : String = "https://maps.googleapis.com/maps/api/geocode/json?address=" + replaced + "&key=" + key
////        var latitude : String
////        var longitude : String
////        Alamofire.request(queryString, method: .get).responseJSON {
////            response in
////            if response.result.isSuccess {
////                let geocodeJSON : JSON = JSON(response.result.value!)
////                latitude = geocodeJSON["results"]["geometry"]["location"]["lat"].string!
////                longitude = geocodeJSON["results"]["geometry"]["location"]["lng"].string!
////                print(latitude)
////                print(longitude)
////                //return (Double(latitude), Double(longitude))
////            } else {
////                print("geocode didnt work")
////            }
////        }
////        return (Double(latitude)!, Double(longitude)!)
////    }
//
//    var theGeocode : (Double, Double) = (0.0, 0.0)
//
//    public func geocode(location: String) {
//        let replaced = String(location.map {$0 == " " ? "+" : $0});
//        let queryString : String = "https://maps.googleapis.com/maps/api/geocode/json?address=" + replaced + "&key=" + key
//        var _ : String
//        var _ : String
//        Alamofire.request(queryString, method: .get).responseJSON {
//            response in
//            if response.result.isSuccess {
//                let geocodeJSON : JSON = JSON(response.result.value!)
//                let latitude : String = geocodeJSON["results"]["geometry"]["location"]["lat"].string!
//                let longitude : String = geocodeJSON["results"]["geometry"]["location"]["lng"].string!
//                print(latitude)
//                print(longitude)
//                self.assignGeocode((Double(latitude)!, Double(longitude)!))
//
//            } else {
//                print("geocode didnt work")
//            }
//        }
//        //return (Double(latitude)!, Double(longitude)!)
//    }
//
//    func assignGeocode(_ theCode: (Double, Double)) {
//        theGeocode = theCode
//    }
//
//    public func getGeocode() -> (Double, Double) {
//        return theGeocode
//    }
//
//    public func ungeocode(latitude: Double, longitude: Double) -> String {
//        let query1 = "https://maps.googleapis.com/maps/api/geocode/json?latlng="
//        let query2 = String(latitude) + "," + String(longitude) + "&key=" + key
//        let queryString = query1 + query2
//        var address : String
//
//        Alamofire.request(queryString, method: .get).responseJSON {
//            response in
//            if response.result.isSuccess {
//                let ungeocodeJSON : JSON = JSON(response.result.value!)
//                address = ungeocodeJSON["results"]["formatted_address"].string!
//                print(address)
//            } else {
//                print("ungeocode didnt work")
//            }
//        }
//        return address
//    }
//}
//
//class lyft {
//    public func getCost(pickup : String, dropoff : String) {
//        var myGoogleHandler = googleHandler()
//        let (pickup_lat, pickup_long) = myGoogleHandler.geocode(location: pickup)
//        let (dest_lat, dest_long) = myGoogleHandler.geocode(location: dropoff)
//
//        let pickup = CLLocationCoordinate2D(latitude: pickup_lat, longitude: pickup_long)
//        let destination = CLLocationCoordinate2D(latitude: dest_lat, longitude: dest_long)
//
//        LyftAPI.costEstimates(from: pickup, to: destination, rideKind: .Standard) { result in
//            result.value?.forEach { costEstimate in
//                print("Min: \(costEstimate.estimate!.minEstimate.amount)$")
//                print("Max: \(costEstimate.estimate!.maxEstimate.amount)$")
//            }
//            // return average of (max-min) / 2 for each cost in cost?
//        }
//    }
//}
