//
//  Algorithm.swift
//  frolic
//
//  Created by Hamna on 10/27/19.
//  Copyright © 2019 adventurers. All rights reserved.
//

import Foundation

/*
    information we have
        origin
        destination
        number of meals
        number of snacks
        money
        transport
 
    * for each meal required, block of time for that, build event around that
        if taking too many meal times, then we cut some out
    * eventbrite times? (currently Time obj for front end, how to be compatible with back-end?
 
    * swiping - keep calling findPlace fitting within the given parameters?
 
 */

 class Event {
    let place : Place
    let time : (Int, Int) // idk what this should look like

    init(place :Place, time :(Int, Int)) {
        self.place = place
        self.time = time
    }
 }

class algorithm {
    public func replace(replacedEvent :Event) {
        var event :Event = nil
        let handler = googleHandler()
        handler.geocode(replacedEvent.place.formatted_address) {
            while (event == nil) {
                lat_lng in 
                handler.findPlace(replacedEvent.place.type, latitude: lat_lng.0, longitude: lat_lng.1, radius :Int = 500) {
                    p in 
                    if (true) { // if the event fits in the time constraints
                        event = Evet(place: p, time: (0,0))
                    }
                }
            }
        }
        return event;
    }

    public func calculateEventPrice(events :Array) -> String {
        var price :Int = 0;
        var count :Int = 0;
        for event in events {
            price += event.place.price_level;
            count += 1;
        }
        return String(repeating: "$", count: price / count)
    }

    public func getLyftPrice(start :String, end: String) {
        let handler = googleHandler()
        handler.getCosts(pickup: start, dropoff: end) {
            cost in return cost
        }
    }
}
