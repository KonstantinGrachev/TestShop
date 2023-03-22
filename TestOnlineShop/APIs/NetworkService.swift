//
//  NetworkService.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 14.03.2023.
//

import Foundation
import Combine

final class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    func getLatest(completion: @escaping (Latest) -> Void) {
        guard let request = RequestType.latest.request else { return }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil, let data = data {
                guard let latest = try? JSONDecoder().decode(Latest.self, from: data) else { return }
                completion(latest)
            } else {
                guard let error = error else { return }
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getSale(completion: @escaping (Sale) -> Void) {
        guard let request = RequestType.flashSale.request else { return }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil, let data = data {
                guard let sale = try? JSONDecoder().decode(Sale.self, from: data) else { return }
                completion(sale)
            }
        }
        task.resume()
    }

    func getDetails(completion: @escaping (Details) -> Void) {
        guard let request = RequestType.details.request else { return }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil, let data = data {
                guard let details = try? JSONDecoder().decode(Details.self, from: data) else { return }
                completion(details)
            }
        }
        task.resume()
    }
    
    func search(for query: String) -> AnyPublisher<[String], Error> {
        guard let request = RequestType.search.request else { return Fail(error: URLError(.badURL)).eraseToAnyPublisher() }
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: [String].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
