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
    var conversion_result : Double
}
struct Utility : Codable{
    static let shared = Utility()
    private init(){
        
    }
    func ExchangeCurrencyRate(from:String, to:String, amount:Double, handler: @escaping([CurrencyData])->Void){
        
        let session = URLSession.shared
        
        let currencyUrl = "https://v6.exchangerate-api.com/v6/cf9c59cee7688ee360c5758d/pair/\(from)/\(to)/\(amount)"
        
        if let url = URL(string: currencyUrl){
            let task = session.dataTask(with: url) { urlData, resp, err in
                if err == nil{
                    let statusCode = (resp as! HTTPURLResponse).statusCode
                    
                    switch statusCode{
                    case 200...299:
                        let parseData = parseData(jsonResponse: urlData)
                        handler(parseData)
                        print("request successfull")
                    case 300...399:
                        print("Redirection")
                    case 400...499:
                        print("not found")
                    case 500...599:
                        print("sever error")
                    default:
                        print("unknown error")
                    }
                }
                else{
                    print("request could not be completed ")
                }
            }
            task.resume()
            
        }
       
    }
    func parseData(jsonResponse: Data?) -> [CurrencyData]{
        guard let jResponse = jsonResponse else{
            return []
        }
        do{
            let currencyLists = try JSONDecoder().decode(CurrencyData.self, from: jResponse)
            return[currencyLists]
        }catch{
            print(error.localizedDescription)
            
        }
        return[]
        
    }
}
