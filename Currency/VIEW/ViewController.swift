//
//  ViewController.swift
//  Currency
//
//  Created by Naidu, Kodidhela (Contractor) on 06/06/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Viewcontroller")
        CurrencyUtility.shared.CurrencyCon { countryCodes in
//            print(countryCodes)
            var country = countryCodes[0]
            var firstCountry = country.supported_codes[1]
            print(country.supported_codes[1][1])
            print(firstCountry[1])
        }
      
       
            
        }
    }




