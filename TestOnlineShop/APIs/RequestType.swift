//
//  RequestType.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 14.03.2023.
//

import Foundation

enum RequestType {
    case latest,
         flashSale,
         details,
         brand,
         search
    
    private var baseURL: String {
        switch self {
        case .latest:
            return "https://run.mocky.io/v3/cc0071a1-f06e-48fa-9e90-b1c2a61eaca7"
        case .flashSale:
            return "https://run.mocky.io/v3/a9ceeb6e-416d-4352-bde6-2203416576ac"
        case .details:
            return "https://run.mocky.io/v3/f7f99d04-4971-45d5-92e0-70333383c239"
        case .brand:
            return "https://run.mocky.io/v3/f7f99d04-4971-45d5-92e0-70333383c239"
        case .search:
            return "https://run.mocky.io/v3/4c9cd822-9479-4509-803d-63197e5a9e19"
        }
    }
    
    var request: URLRequest? {
        guard let url = URL(string: baseURL) else { return nil }
        let request = URLRequest(url: url)
        return request
    }
}



