//
//  UserModel.swift
//  TestOnlineShop
//
//  Created by Konstantin Grachev on 19.03.2023.
//

import Foundation

final class UserModel: Codable {
    let firstname: String
    let lastname: String?
    let email: String?
    var image: String?
    var isLogged: Bool
    
    init(firstname: String, lastname: String?, email: String?, image: String?, isLogged: Bool) {
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.image = image
        self.isLogged = isLogged
    }
    
    public enum CodingKeys: String, CodingKey {
        case firstname, lastname, email, image, isLogged
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.firstname = try container.decode(String.self, forKey: .firstname)
        self.lastname = try container.decodeIfPresent(String.self, forKey: .lastname)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.isLogged = try container.decode(Bool.self, forKey: .isLogged)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(self.firstname, forKey: .firstname)
        try container.encode(self.lastname, forKey: .lastname)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.image, forKey: .image)
        try container.encode(self.isLogged, forKey: .isLogged)
    }
}
