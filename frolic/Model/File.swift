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
