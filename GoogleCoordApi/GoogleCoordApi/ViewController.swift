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
    
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
    }
    
    @IBAction func convertButtonTapped(_ sender: UIButton) {
        guard let address = self.addressTextField.text else {print("Address field failed-nil"); return }
        
        GoogleApiClient.getCoordJson(address: address) { (lat,long) in

            print(GoogleApiClient.errorString.count)
            
            if  GoogleApiClient.errorString.count > 0 {
                DispatchQueue.main.async {
                    self.errorLabel.isHidden = false
                    self.errorLabel.text = GoogleApiClient.errorString
                }
            } else {
                
                DispatchQueue.main.async {
                    self.errorLabel.isHidden = true
                    self.latLabel.text = "\(lat)"
                    self.longLabel.text = "\(long)"
                }
            }
            
            
//            if  self.errorFlag {
//                self.errorLabel.isHidden = false
//                self.errorLabel.text = self.errString
//            } else {
//                self.errorLabel.isHidden = true
//
//                DispatchQueue.main.async {
//                    self.latLabel.text = "\(lat)"
//                    self.longLabel.text = "\(long)"
//                }
//            }
        }
    }
}

