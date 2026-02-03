//
//  User.swift
//  interview projects
//
//  Created by Quinn Liu on 2/1/26.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let username: String
    let email: String
        //    let address: Address
    let phone: String
    let website: String
        //    let company: Company
    
    enum CodingKeys: String, CodingKey {
        case id, name, username, email, phone, website
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try String(container.decode(Int.self, forKey: .id))
        self.name = try container.decode(String.self, forKey: .name)
        self.username = try container.decode(String.self, forKey: .username)
        self.email = try container.decode(String.self, forKey: .email)
        self.phone = try container.decode(String.self, forKey: .phone)
        self.website = try container.decode(String.self, forKey: .website)
    }
    
}


    //{
    //    "id": 9,
    //    "name": "Glenna Reichert",
    //    "username": "Delphine",
    //    "email": "Chaim_McDermott@dana.io",
    //    "address": {
    //        "street": "Dayna Park",
    //        "suite": "Suite 449",
    //        "city": "Bartholomebury",
    //        "zipcode": "76495-3109",
    //        "geo": {
    //            "lat": "24.6463",
    //            "lng": "-168.8889"
    //        }
    //    },
    //    "phone": "(775)976-6794 x41206",
    //    "website": "conrad.com",
    //    "company": {
    //        "name": "Yost and Sons",
    //        "catchPhrase": "Switchable contextually-based project",
    //        "bs": "aggregate real-time technologies"
    //    }
    //}
