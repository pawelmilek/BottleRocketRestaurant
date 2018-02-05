//
//  Restaurant.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation

struct Restaurant: Decodable {
    var name: String
    var backgroundImageURL: String
    var category: CategoryType
    var contact: Contact?
    var location: Location
}


// MARK: Decodable protocol
extension Restaurant {
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case backgroundImageURL = "backgroundImageURL"
        case category = "category"
        case contact = "contact"
        case location = "location"
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let name: String = try container.decode(String.self, forKey: .name)
        let backgroundImageURL: String = try container.decode(String.self, forKey: .backgroundImageURL)
        let category: String = try container.decode(String.self, forKey: .category)
        let categoryType = CategoryType(rawValue: category) ?? CategoryType.none
        let contact: Contact? = try container.decodeIfPresent(Contact.self, forKey: .contact)
        let location: Location = try container.decode(Location.self, forKey: .location)
        
        self.init(name: name, backgroundImageURL: backgroundImageURL, category: categoryType, contact: contact, location: location)

    }
    
}

