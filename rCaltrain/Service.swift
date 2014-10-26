//
//  Service.swift
//  rCaltrain
//
//  Created by Wanzhang Sheng on 10/25/14.
//  Copyright (c) 2014 Ranmocy. All rights reserved.
//

import Foundation

class Service {

    let category: String
    let stops: [Stop]

    init(id: String, stops: [Stop]) {
        // FIXME: should has better way to split
        if let range = id.rangeOfString("-", options: .RegularExpressionSearch) {
            self.category = id.splits({$0 == "-"}, allowEmptySlices: false)[1]
        } else{
            fatalError("invalid service id, since no '-' in it.")
        }
        self.stops = stops
    }

    func findFrom(from: Station, to: Station) -> (Stop, Stop)? {
        var i: Int = 0
        var fromStop: Stop, toStop: Stop

        // find the departure stop
        while (i < stops.count){
            if (stops[i].station === from) {
                break
            }
            i++
        }

        // if missing
        if i >= stops.count {
            return nil
        }

        // if found
        fromStop = stops[i]

        // from and to can't be the same
        i++

        // find the arrival stop
        while (i < stops.count) {
            if (stops[i].station === to) {
                break
            }
            i++
        }

        // if missing
        if (i >= stops.count) {
            return nil
        }
        
        // if found
        toStop = stops[i]

        return (fromStop, toStop)
    }

}