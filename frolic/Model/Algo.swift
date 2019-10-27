//
//  Algo.swift
//  frolic
//
//  Created by Huda T on 10/27/19.
//  Copyright © 2019 adventurers. All rights reserved.
//

import Foundation

class Algo {
    
    var userStartTime : [Int] = []
    var userEndTime : [Int] = []
    
    let foodTimes : [[Int]] = [[8, 00, 00], [12, 00, 00], [18, 00, 00]]
    let snackTimes : [[Int]] = [[10, 00, 00],[15, 00, 00],[21, 00, 00]]
    
    let allFoodTimes : [[Int]] = [[8, 00, 00, 1], [10, 00, 00, 2], [12, 00, 00, 1], [15, 00, 00, 2], [18, 00, 00, 1], [21, 00, 00, 2]]
    
    
    var foodBreaksWithinDay : [(String, (Int, Int))] = []
    
    var allIntervals : [(String, (Int, Int))] = []
        //"M" -> Meal
        //"S" -> Snack
        //"NF" -> Non Food
        //"EB" -> EventBrite
        //"G" -> Google
    
            //Maybe Split from the get go if Eventbright or not
    
    func parseDay(_ startTime : Date, _ endTime : Date) {
        print(startTime)
        print(endTime)
        let startString : String = String(describing: startTime)
        
        let stringArray = startString.components(separatedBy: " ")
        let finalParse = stringArray[1].components(separatedBy: ":")
        
        let endString : String = String(describing: endTime)
        
        let stringArray2 = endString.components(separatedBy: " ")
        let finalParse2 = stringArray2[1].components(separatedBy: ":")
        
        var finalIntVersion : [Int] = [0,0,0]
        var finalIntVersion2 : [Int] = [0,0,0]
        
        finalIntVersion[0] = Int(finalParse[0])! - 4
        if (finalIntVersion[0] < 0) {
            finalIntVersion[0] = finalIntVersion[0] + 24
        }
        finalIntVersion[1] = Int(finalParse[1])!
        finalIntVersion[2] = Int(finalParse[2])!
        
        finalIntVersion2[0] = Int(finalParse2[0])! - 4
        if (finalIntVersion2[0] < 0) {
            finalIntVersion2[0] = finalIntVersion2[0] + 24
        }
        finalIntVersion2[1] = Int(finalParse2[1])!
        finalIntVersion2[2] = Int(finalParse2[2])!
        
        userStartTime = finalIntVersion
        userEndTime = finalIntVersion2
        
        print("userStartTime: ")
        print(userStartTime)
        print("userEndTime: ")
        print(userEndTime)
    }
    
    func findIntervals() {
        for i in 0..<6 {
            //----
            if allFoodTimes[i][0] >= userStartTime[0] && allFoodTimes[i][0] <= userEndTime[0] {
                var foodType : String = ""
                
                if allFoodTimes[i][3] == 1 {
                    foodType = "M"
                } else {
                    foodType = "S"
                }
                    
                let currTime : (String, (Int, Int)) = (foodType, (allFoodTimes[i][0], allFoodTimes[i][0] + 1))
                foodBreaksWithinDay.append(currTime)
            }
        }
        
        var breaksPart2 : [(String, (Int, Int))] = []
        
        print(userStartTime)
        print(foodBreaksWithinDay)
        
        if (userStartTime[0] != foodBreaksWithinDay[0].1.0) {
            let addMe : (String, (Int, Int)) = ("NF", (userStartTime[0], foodBreaksWithinDay[0].1.0))
            breaksPart2.append(addMe)
        }
        
        for i in 0..<foodBreaksWithinDay.count {
            breaksPart2.append(foodBreaksWithinDay[i])
        }
        
        if (userEndTime[0] != foodBreaksWithinDay[foodBreaksWithinDay.count - 1].1.0) {
            let addMe : (String, (Int, Int)) = ("NF", (foodBreaksWithinDay[foodBreaksWithinDay.count - 1].1.0, userEndTime[0]))
            breaksPart2.append(addMe)
        }
        
        var final : [(String, (Int, Int))] = []
        for i in 1..<breaksPart2.count {
            if breaksPart2[i - 1].1.1 != breaksPart2[i].1.0 {
                let addMe : (String, (Int, Int)) = ("NF", (breaksPart2[i - 1].1.1, breaksPart2[i].1.0))
                  
                breaksPart2.append(addMe)
                final.append(breaksPart2[i - 1])
                final.append(addMe)
            } else {
                final.append(breaksPart2[i - 1])
            }
        }
        final.append(breaksPart2[breaksPart2.count - 1])
        
        print("Not in order")
        print(breaksPart2)
        print("Hopefully in order")
        print(final)
        
        print("COUNT: no order")
        print(breaksPart2.count)
        print("COUNT: hopefully order")
        print(final.count)
    }
}
