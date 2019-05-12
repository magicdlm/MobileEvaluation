//
//  Model.swift
//  FancyCars
//
//  Created by Leming Deng on 2019-05-11.
//  Copyright © 2019 Leming Deng. All rights reserved.
//

import Foundation

struct Car: Codable {
    let id: Int
    let img: String
    let name, make, model: String
    let year: Int
}

struct AvailablilityResponse: Codable {
    enum Available: String, Codable, OrderedCaseIterable {
        case inDealership = "In Dealership"
        case outOfStock = "Out of Stock"
        case unavailable = "Unavailable"
    }
    let available: Available
}
