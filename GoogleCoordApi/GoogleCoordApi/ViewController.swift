//
//  ViewController.swift
//  GoogleCoordApi
//
//  Created by Emiko Clark on 3/20/18.
//  Copyright © 2018 Emiko Clark. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var gac = GoogleApiClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let address = "27+e+13th+Street,+NY,+NY+10003"
        GoogleApiClient.getCoordJson(address: address) { (lat,long) in
            print(lat, long)
        }
    }

}

