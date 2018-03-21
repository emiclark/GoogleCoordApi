//
//  GoogleApiClient.swift
//  GoogleCoordApi
//
//  Created by Emiko Clark on 3/20/18.
//  Copyright © 2018 Emiko Clark. All rights reserved.
//

import Foundation

class GoogleApiClient {
    
    static var lat: Double?
    static var long: Double?
    static var vc = ViewController()
    
    class func getCoordJson(address: String, completion: @escaping(Double,Double)->()) {

        let addressConverted = address.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)

        
        let urlString = "https://maps.googleapis.com/maps/api/geocode/json?address=\(addressConverted)&key=\(secrets.googleApiKey)"
        
        guard let urlConverted = URL(string: urlString) else {print("url failed");  return}
        
        URLSession.shared.dataTask(with: urlConverted) { (data, response, error) in
            
            guard let data = data else {print("data nil"); vc.errorFlag = true; return }
            
            let jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            guard let json = jsonDict else { print("json conversion failed"); return }
            
            // parse
            guard let resultsArr = json["results"] as? Array<Any> else {print("results array failed"); return }
            
            guard let firstElement = resultsArr.first as? [String:Any] else { print("failed"); return }
            guard let geometryDict = firstElement["geometry"] as? [String: Any] else { print("gemometry failed"); return }
            guard let locationDict = geometryDict["location"] as? [String:Any] else {print("location failed"); vc.errorFlag = true; return }
            
            guard let latcoord = locationDict["lat"] as? Double,
                let longcoord = locationDict["lng"] as? Double
                else {print("location failed");vc.errorFlag = true; return }
            
            lat = latcoord
            long = longcoord
            
            completion(lat!,long!)

        }.resume()
    }
}
