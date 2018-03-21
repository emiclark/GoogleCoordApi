//
//  GoogleApiClient.swift
//  GoogleCoordApi
//
//  Created by Emiko Clark on 3/20/18.
//  Copyright © 2018 Emiko Clark. All rights reserved.
//

import Foundation

class GoogleApiClient {
    
    class func getCoordJson(address: String, completion: @escaping([String:Any])->()) {
        
        let urlString = "https://maps.googleapis.com/maps/api/geocode/json?address=\(address)&key=\(secrets.googleApiKey)"
        
        guard let urlConverted = URL(string: urlString) else {print("url failed"); return}
        
        URLSession.shared.dataTask(with: urlConverted) { (data, response, error) in
            
            guard let data = data else {print("data nil"); return }
            
            let jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            guard let json = jsonDict else { print("json conversion failed"); return }
            
            // parse
            guard let resultsArr = json["results"] as? Array<Any> else {print("results array failed"); return }
            
            guard let firstElement = resultsArr.first as? [String:Any] else { print("failed"); return }
            guard let geometryDict = firstElement["geometry"] as? [String: Any] else { print("gemometry failed"); return }
            guard let locationDict = geometryDict["location"] as? [String:Any] else {print("location failed"); return }
            
            completion(locationDict)

        }.resume()
    }
}
