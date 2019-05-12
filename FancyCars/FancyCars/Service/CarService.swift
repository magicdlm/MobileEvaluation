//
//  CarService.swift
//  FancyCars
//
//  Created by Leming Deng on 2019-05-11.
//  Copyright © 2019 Leming Deng. All rights reserved.
//

import Foundation

protocol CarService {
    func getCars(onComplete: @escaping (Result<[Car], Error>) -> Void)
    
    func checkAvailability(for id: Int, result: @escaping (Result<AvailablilityResponse, Error>) -> Void)
}

final class StubCarService: CarService {
    
    func getCars(onComplete: @escaping (Result<[Car], Error>) -> Void) {
        let url = Bundle.main.url(forResource: "Cars", withExtension: "json")!
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            do {
                let data = try Data(contentsOf: url)
                onComplete(.success(try JSONDecoder().decode([Car].self, from: data)))
            } catch {
                onComplete(.failure(error))
            }
        }
    }
    
    func checkAvailability(for id: Int, result: @escaping (Result<AvailablilityResponse, Error>) -> Void) {
        let suffix = id % 3
        let url = Bundle.main.url(forResource: "Availablility\(suffix)", withExtension: "json")!
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            do {
                let data = try Data(contentsOf: url)
                result(.success(try JSONDecoder().decode(AvailablilityResponse.self, from: data)))
            } catch {
                result(.failure(error))
            }
        }
    }
    
}
