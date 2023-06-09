//
//  SecondVC.swift
//  Currency
//
//  Created by Naidu, Kodidhela (Contractor) on 08/06/23.
//

import UIKit

class SecondVC: UIViewController{
        
    
    
    @IBOutlet weak var countrysearch: UISearchBar!
    
    @IBOutlet weak var countryNamesTV: UITableView!
    
//    var filterCountryNames=[String]()
    
    var countryDetails : [ExchangeRateCodeREsponse] = []
    
    var array : [String] = []
    var array2 : [String] = []
//
   var searchCountry = [String]()
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Utility.shared.ExchangeCurrencyRate(from: "USD", to: "EUR", amount: 100) { fetchedData in
            print(fetchedData)
        }
        
//        self.filterCountryNames = array

        
//        let searchController = UISearchController(searchResultsController: nil)
//        searchController.searchBar.placeholder = "Search"
//        searchController.searchBar.searchBarStyle = .minimal
        
        countryNamesTV.dataSource = self
       // countryNamesTV.
        
        CurrencyUtility.shared.CurrencyCon { countryData in
            self.countryDetails = countryData
            
            countryData[0].supported_codes.forEach { country in
               
                self.array.append(country[1])
                
            
            }
            countryData[0].supported_codes.forEach { countryCode in
               
                self.array2.append(countryCode[0])
                
            
            }
            
           // print("Country List:\(self.array.sorted())")
    
            let ind = self.countryDetails[0].supported_codes[0][1]
            print("Ind: \(ind)")
            DispatchQueue.main.async {
                self.countryNamesTV.reloadData()
                
                
            }
            
            print(self.countryDetails)
            
            print(self.countryDetails[0].supported_codes[0][1])
        }
        // Do any additional setup after loading the view.
    }
}


//extension SecondVC : UITableViewDelegate{
//
//
//
//}
extension SecondVC :UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //        if !countryDetails.isEmpty{
        //
        //            return countryDetails[0].supported_codes.count
        //        }else{
        //            return 0
        //        }
        if searching{
            print(searchCountry)
             return searchCountry.count

        }else{
            print("array:\(array)")
            return array.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countryNamesTV.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
       // let sortedData = countryDetails[0].supported_codes
       // let country = countryDetails[0].supported_codes[indexPath.row][1]
//        print(countryDetails[0].supported_codes.count)
        let country = array.sorted()[indexPath.row]
        if searching{
            cell.textLabel?.text = searchCountry[indexPath.row]
            
        }else{
            cell.textLabel?.text = "\(country)"
            cell.detailTextLabel?.text = countryDetails[0].supported_codes[indexPath.row][0]
        }
        
//        let country = array.sorted()[indexPath.row]
        
//        print("AaAAAAAA\(indexPath.row)")
        
//        cell.textLabel?.text = "\(country)"
        print(country)

        return cell
    }
    
    
}


extension SecondVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCountry = array.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        countryNamesTV.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        countryNamesTV.reloadData()
    }
}
