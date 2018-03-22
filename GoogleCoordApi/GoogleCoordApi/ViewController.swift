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
//    var errorFlag: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
    }
    
    @IBAction func convertButtonTapped(_ sender: UIButton) {
        self.errorLabel.isHidden = true
        guard let address = self.addressTextField.text else {print("Address field failed-nil"); return }
        
        GoogleApiClient.getCoordJson(address: address) { (lat,long) in
            if lat != nil && long != nil {
                OperationQueue.main.addOperation {
                    self.latLabel.text = "\(lat)"
                    self.longLabel.text = "\(long)"
                    self.errorLabel.isHidden = true
                }
            }
            else{
                OperationQueue.main.addOperation {
                self.errorLabel.isHidden = false
                }
            }

        }
    }
}

