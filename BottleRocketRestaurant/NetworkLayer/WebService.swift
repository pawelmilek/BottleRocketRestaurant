//
//  WebService.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import Foundation
import UIKit

struct WebService {
    static let shared = WebService()
    
    private let endpoint = "http://sandbox.bottlerocketapps.com/BR_iOS_CodingExam_2015_Server/restaurants.json"
    typealias RestaurantRequestCompletion = (WebServiceResultType<RestaurantResponse, WebServiceError>) -> ()
    
    private init() {}
}


// MARK: - Request restaurants data
extension WebService {

    func requestRestaurantsData(completionHandler: @escaping RestaurantRequestCompletion) {
        guard let url = URL(string: endpoint) else {
            let error = WebServiceError.unknownURL(reason: "Fail to create URL: \(endpoint)")
            completionHandler(.failure(error))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest, completionHandler: {(data, response, error) in
            guard error == nil else {
                completionHandler(.failure(WebServiceError.requestFailed))
                return
            }
            
            guard let responseData = data else {
                completionHandler(.failure(WebServiceError.dataNotAvailable))
                return
            }
            
            do {
                let restaurants = try JSONDecoder().decode(RestaurantResponse.self, from: responseData)
                completionHandler(.success(restaurants))
                
            } catch let error {
                print(error)
                completionHandler(.failure(WebServiceError.decodeFailed))
            }
        }).resume()
    }
    
}
