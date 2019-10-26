//
//  File.swift
//  frolic
//
//  Created by Huda T on 10/26/19.
//  Copyright © 2019 adventurers. All rights reserved.
//

import Foundation
//import CoreLocation

class eventbriteHandler {
    
    let eventbrite_key = "ZYFPUYLPXW6SGOSVFTNB"
    let end_url = "/v3/users/me/?token=ZYFPUYLPXW6SGOSVFTNB" //append the key
    let end_url_simple = "?token=ZYFPUYLPXW6SGOSVFTNB" //append the key
    //https://www.eventbriteapi.com/v3/categories/
    let all_event_categories = "https://www.eventbriteapi.com/v3/categories/?token=ZYFPUYLPXW6SGOSVFTNB"
    
    let example = "https://www.eventbriteapi.com/v3/events/search/start_date.range_start=next_month/?token=ZYFPUYLPXW6SGOSVFTNB"
    
    //start_date.range_start=YYYY-MM-DDThh:mm:ssZ
    
    let sampleURL = "https://www.eventbriteapi.com/v3/events/search/?start_date.keyword=this_week&token=ZYFPUYLPXW6SGOSVFTNB"
    
    //let locationManager = CLLocationManager()
    
    
}
