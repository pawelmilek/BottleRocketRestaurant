//
//  Location.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation

struct Location: Address {
    var street: String
    var city: String
    var state: String
    var zipcode: String?
    var country: String
    var countryCode: String
    var crossStreet: String?
    var coordinate: Coordinate
    var completeAddress: String
}


// MARK: - Decodable protocol
extension Location: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case street = "address"
        case city = "city"
        case state = "state"
        case zipcode = "postalCode"
        case country = "country"
        case countryCode = "cc"
        case crossStreet = "crossStreet"
        case latitude = "lat"
        case longitude = "lng"
        case formattedAddress = "formattedAddress"
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let street: String = try container.decode(String.self, forKey: .street)
        let city: String = try container.decode(String.self, forKey: .city)
        let state: String = try container.decode(String.self, forKey: .state)
        let zipcode: String? = try container.decodeIfPresent(String.self, forKey: .zipcode)
        let country: String = try container.decode(String.self, forKey: .country)
        let countryCode: String = try container.decode(String.self, forKey: .countryCode)
        let crossStreet: String? = try container.decodeIfPresent(String.self, forKey: .crossStreet)
        let latitude: Double  = try container.decode(Double.self, forKey: .latitude)
        let longitude: Double = try container.decode(Double.self, forKey: .longitude)
        let coordinate = Coordinate(latitude: latitude, longitude: longitude)
        let formattedAddress: [String] = try container.decode([String].self, forKey: .formattedAddress)
        let completeAddress: String = formattedAddress.joined(separator: " ")
        
        
        self.init(street: street, city: city, state: state, zipcode: zipcode, country: country, countryCode: countryCode, crossStreet: crossStreet, coordinate: coordinate, completeAddress: completeAddress)
    }

}
