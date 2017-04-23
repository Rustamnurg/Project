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

//transport. route. direction. stop.

enum EventFlow {
    case transport
    case route
    case direction
    case stop
    
    var state: Int {
        switch self {
        case .transport: return 0
        case .route: return 1
        case .direction: return 2
        case .stop: return 3
        }
    }
    
    var defaultName: String {
        switch self {
        case .transport: return ""
        case .route: return "   Маршрут"
        case .direction: return "   Направление"
        case .stop: return "   Остановка"
        }
    }
    
    
    //transport. route. direction. stop.
}

//enum EventFlow {
//    case transport
//    case route
//    case direction
//    case stop
//
//    var state: String {
//        switch self {
//        case .transport: return "transport"
//        case .route: return "route"
//        case .direction: return "direction"
//        case .stop: return "stop"
//        }
//
//    }
//
//
//    //transport. route. direction. stop.
//}



enum RideEnum {
    case bus
    case tramway
    case trolleybus
    
    var identifier: String {
        switch self {
        case .bus: return "bus"
        case .tramway: return "tramway"
        case .trolleybus: return "trolleybus"
        }
    }
    
    var baseUrl: String {
        switch self {
        case .bus: return "route"
        case .tramway: return "20"
        case .trolleybus: return "18"
        }
    }
}

//enum SearchIdentifier {
//    case route
//    case direction
//    case stop
//
//    var identifier: String {
//        switch self {
//        case .route: return "route"
//        case .direction: return "direction"
//        case .stop: return "stop"
//        }
//    }
//
//
//}


