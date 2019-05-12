//
//  ViewModel.swift
//  FancyCars
//
//  Created by Leming Deng on 2019-05-11.
//  Copyright © 2019 Leming Deng. All rights reserved.
//

import Foundation

final class ViewModel {
    typealias Data = (car: Car, availablility: AvailablilityResponse.Available)
    
    enum SortBy: Int {
        case name, availability
        
        fileprivate func isBefore(l: Data, r: Data) -> Bool {
            switch self {
            case .name:
                return l.car.name < r.car.name
            case .availability:
                return l.availablility < r.availablility
            }
        }
    }
    
    var sort: SortBy?
    
    private var raw = [Data]()
    private let service: CarService
    
    
    var cars: [Data] {
        guard let sort = sort else { return raw }
        return raw.sorted(by: sort.isBefore)
    }
    
    init(service: CarService = StubCarService()) {
        self.service = service
    }
    
    func fetchCars(onFinish: @escaping (ViewModel) -> Void) {
        raw.removeAll()
        service.getCars { (result) in
            switch result {
            case .success(let data):
                var map = [Int: AvailablilityResponse.Available]()
                
                let group = DispatchGroup()
                data.forEach { (car) in
                    group.enter()
                    self.service.checkAvailability(for: car.id, result: { (avaResult) in
                        map[car.id] = try? avaResult.get().available
                        group.leave()
                    })
                }
                
                group.notify(queue: .main, execute: {
                    self.raw = data.map { ($0, map[$0.id] ?? .unavailable) }
                    self.save()
                    onFinish(self)
                })
            case .failure(_):
                self.load()
                onFinish(self)
            }
            
        }
    }
}

// MARK: - Offline mode
fileprivate struct Container: Codable {
    let car: Car
    let availablility: AvailablilityResponse.Available
}

private extension ViewModel {
    private static let key = "offline-data"
    func save() {
        let json = try! JSONEncoder().encode(raw.map(Container.init))
        UserDefaults().set(json, forKey: ViewModel.key)
    }
    
    func load() {
        guard let data = UserDefaults().data(forKey: ViewModel.key),
            let containers = try? JSONDecoder().decode([Container].self, from: data) else { return }
        raw = containers.map(toData(_:))
    }
    
    private func toData(_ c: Container) -> Data {
        return (c.car, c.availablility)
    }
}
