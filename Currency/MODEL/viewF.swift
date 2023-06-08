//
//  viewF.swift
//  Currency
//
//  Created by Naidu, Kodidhela (Contractor) on 06/06/23.
//

import Foundation
import CoreData

struct CurrencyData: Codable{
    var base_code : String
    var target_code : String
    var conversion_rate : Double
    var conversion_result : String
}
//struct Utility{
//    static let shared = Utility()
//    private init(){
//
//    }
    
//    func FetchExchangeDataRate(){
//
//        let session = URLSession.shared
//
//        let webURL = "https://v6.exchangerate-api.com/v6/cf9c59cee7688ee360c5758d/pair/EUR/GBP/100"
//
//        if let url = URL(string: webURL) {
//
//            let task = session.dataTask(with: url){ urlData, resp, err In
//                if err == nil{
//                    let statusCode = (resp as! HTTPURLResponse).statusCode
//                    
//                }
//            }
//            
//        }
//        
//        
//    }
//}
