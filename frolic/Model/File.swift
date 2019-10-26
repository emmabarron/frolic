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

class googleHandler {

    //-----KEY------
    let key = "AIzaSyBZxaCnQa-YCja2TMDp8rHg41PtUEV5IQo"
    let GMSPlacesClient.provideAPIKey(key)

    public func getTravelTime(travelMode : String, origin : String, destination : String) -> Int {
        var travel_mode : String = "mode=" + travelMode;
        let destinationsArg = "destinations=" + String(destination.map {$0 == " " ? "+" : $0});
        var originsArg = "origins=" + String(origin.map {$0 == " " ? "+" : $0});
        let queryString = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&"
            + originsArg + "&" + destinationArg + "&" + travel_mode + "&key=" + key;

        Alamofire.request(queryString, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                let googleMapJSON : JSON = JSON(response.result.value!)
                let duration = googleMapJSON["rows"]["elements"]["duration"]["text"]
                print("durationSeconds \(duration / 60)")
                return duration / 60
            } else {
                print("getTravelTime didnt work")
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
    // }

    public func geocode(location: String) -> (Double, Double) {
        let replaced = String(location.map {$0 == " " ? "+" : $0});
        var queryString : String = "https://maps.googleapis.com/maps/api/geocode/json?address=" + replaced + "&key=" + key

        Alamofire.request(queryString, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                let geocodeJSON : JSON = JSON(response.result.value!)
                let latitude : Double = Double(geocodeJSON["results"]["geometry"]["location"]["lat"])
                let longitude : Double = Double(geocodeJSON["results"]["geometry"]["location"]["lng"])
                print(latitude)
                print(longitude)
                return (latitude, longitude)
            } else {
                print("geocode didnt work")
            }
        }
    }

    public func ungeocode(latitude: Double, longitude: Double) -> String {
        var queryString = "https://maps.googleapis.com/maps/api/geocode/json?latlng=" + latitude + "," + longitude + "&key=" + key;
        Alamofire.request(queryString, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                let ungeocodeJSON : JSON = JSON(response.result.value!)
                let address = ungeocodeJSON["results"]["formatted_address"]
                print(address)
                return address
            } else {
                print("ungeocode didnt work")
            }
        }
    }
}

class lyft {
    public func getCost(pickup : String, dropoff : String) {
        var myGoogleHandler = googleHandler()
        (pickup_lat, pickup_long) = myGoogleHandler.geocode(pickup)
        (dest_lat, dest_long) = myGoogleHandler.geocode(dropoff)

        let pickup = CLLocationCoordinate2D(latitude: pickup_lat, longitude: pickup_long)
        let destination = CLLocationCoordinate2D(latitude: dest_lat, longitude: dest_long)

        LyftAPI.costEstimates(from: pickup, to: destination, rideKind: .Standard) { result in
            result.value?.forEach { costEstimate in
                print("Min: \(costEstimate.estimate!.minEstimate.amount)$")
                print("Max: \(costEstimate.estimate!.maxEstimate.amount)$")
            }
            // return average of (max-min) / 2 for each cost in cost?
        }
    }
}