//
//  CountryCodes.swift
//  Currency
//
//  Created by Naidu, Kodidhela (Contractor) on 08/06/23.
//

import Foundation
import CoreData



struct ExchangeRateCodeREsponse : Codable {
    let supported_codes:[[String]]
}
 
struct CurrencyUtility{
    
    static var shared = CurrencyUtility()
    private init(){
        
    }
    
    func CurrencyCon(handler: @escaping([ExchangeRateCodeREsponse]) -> Void) {
        
        let session = URLSession.shared
        
        let codesUrl = "https://v6.exchangerate-api.com/v6/cf9c59cee7688ee360c5758d/codes"
        
        if let url = URL(string: codesUrl){
            
            let task = session.dataTask(with: url){ urlData, resp, err in
                if err == nil{
                    let statusCode = (resp as! HTTPURLResponse) .statusCode
                    
                    switch statusCode{
                    case 200...299:
                        
                        print(" successfull")
                        
                        let parseData = parseData(jsonResponse: urlData)
                        handler(parseData)
                    case 300...399:
                        print("Redirection")
                    case 400...499:
                        print("not found")
                    case 500...599:
                        print("sever error")
                    default:
                        print("unknown error")
                    }
                }else{
                    print("request could not completed")
                }
            }
            task.resume()
        }
        
    }
    
    func parseData(jsonResponse: Data?) ->[ExchangeRateCodeREsponse]{
        guard let jResponse = jsonResponse else{
            return[]
        }
        do{
            let codeLists = try JSONDecoder().decode(ExchangeRateCodeREsponse.self, from: jResponse)
            return [codeLists]
        }catch{
            print("\(error.localizedDescription)")
        }
        return[]
    }
    
    
}
 
