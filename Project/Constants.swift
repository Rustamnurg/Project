//
//  Constants.swift
//  Project
//
//  Created by Rustam N on 11.04.17.
//  Copyright © 2017 Test. All rights reserved.
//

import Foundation


struct Constants {
    static let baseUrl = ""
    //route. direction. stop
    
}

enum RideEnum{
    case bus
    case tramway
    case trolleybus
    
    var identifier: String{
        switch self {
        case .bus: return "bus"
        case .tramway: return "tramway"
        case .trolleybus: return "trolleybus"
        }
    }
    
    var baseUrl: String{
        switch self {
        case .bus: return "route"
        case .tramway: return "20"
        case .trolleybus: return "18"
        }
    }
}

enum SearchIdentifier{
    case route
    case direction
    case stop
    
    var identifier: String{
        switch self {
        case .route: return "route"
        case .direction: return "direction"
        case .stop: return "stop"
        }
    }


}


