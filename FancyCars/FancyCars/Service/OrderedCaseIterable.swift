//
//  OrderedCaseIterable.swift
//  FancyCars
//
//  Created by Leming Deng on 2019-05-11.
//  Copyright © 2019 Leming Deng. All rights reserved.
//

import Foundation

protocol OrderedCaseIterable: CaseIterable, Comparable {
    var order: Int { get }
    static func from(order: Int) -> Self?
}

extension OrderedCaseIterable  {
    static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.order < rhs.order
    }
    
    var order: Int {
        return Self.array.firstIndex(of: self)!
    }
    
    static func from(order: Int) -> Self? {
        return Self.allCases.first { $0.order == order }
    }
    
    static var array: [Self] {
        return allCases.map({$0})
    }
}
