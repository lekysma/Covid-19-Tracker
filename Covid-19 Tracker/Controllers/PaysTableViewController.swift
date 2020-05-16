//
//  PaysTableViewController.swift
//  Covid-19 Tracker
//
//  Created by Jean martin Kyssama on 11/05/2020.
//  Copyright © 2020 Jean martin Kyssama. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

//MARK: - Table view cell

class CountryDataTableViewCell: UITableViewCell {
    @IBOutlet weak var CountryNameLabel: UILabel!
    @IBOutlet weak var confirmedCasesLabel: UILabel!    
    @IBOutlet weak var deathsLabel: UILabel!
    @IBOutlet weak var recoveriesLabel: UILabel!
    
}

class PaysTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        
        // on augmente la taille des cellules
        tableView.rowHeight = 150
        
        //http call
        httpCall()
        
        tableView.reloadData()
        
    }
        
    //MARK: - Relevant data
    var countryList = [CountryDataModel]()
    var covidDataAPI = "https://api.covid19api.com/summary"

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return countryList.count
    }

    //
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CountryDataTableViewCell

        // Configure the cell...
        let indexPath = countryList[indexPath.row]
        
        //size of the cell
        
        
        //cell.textLabel?.text = indexPath.countryName
        cell.CountryNameLabel.text = "\(indexPath.countryName)"
        cell.confirmedCasesLabel.text = "Confirmed cases: \(indexPath.casesData)"
        cell.deathsLabel.text = "Deaths: \(indexPath.deathsData)"
        cell.recoveriesLabel.text = "Recoveries: \(indexPath.recoveriesData)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("success")
    }

 
    func listOfCountryAndRelatedData() {
        
        let country1 = CountryDataModel(country: "Algeria", cases: "0", deaths: "0", recoveries: "0")
        countryList.append(country1)
        
        let country2 = CountryDataModel(country: "Bahamas", cases: "0", deaths: "0", recoveries: "0")
        countryList.append(country2)
        
        let country3 = CountryDataModel(country: "Seychelles", cases: "0", deaths: "0", recoveries: "0")
        countryList.append(country3)
        
        //on recharge la table juste au cas ou
        tableView.reloadData()
    }
    
    //MARK: - HTTP CALL
    
    func httpCall() {
        request(covidDataAPI, method: .get).responseJSON { (response) in
            //succes, facon differente de l'ecrire
            if !response.result.isFailure {
                let globalDataJSON: JSON = JSON(response.result.value)
     
                //l'idee est de cycle pour chaque pays
                for index in 0...globalDataJSON["Countries"].count {
                    let countryNameJSON = globalDataJSON["Countries"][index]["Country"].stringValue
                    let casesPerCountryJSON = globalDataJSON["Countries"][index]["TotalConfirmed"].stringValue
                    let deathsPerCountryJSON = globalDataJSON["Countries"][index]["TotalDeaths"].stringValue
                    let recoveriesPerCountryJSON = globalDataJSON["Countries"][index]["TotalRecovered"].stringValue
                    //print(countryNameJSON)
                    
                    //ensuite on vide le talbeau actuel
                   // self.countryList.removeAll()
                    //ensuite on cree un nouvel objet avec comme proprietes les valeurs ci dessus
                    let newObject = CountryDataModel(country: countryNameJSON, cases: casesPerCountryJSON, deaths: deathsPerCountryJSON, recoveries: recoveriesPerCountryJSON)
                    //on ajoute au tableau
                    self.countryList.append(newObject)
                    //enfin on recharge la table
                    self.tableView.reloadData()
                    
                    
                }
                
            }
        }
    }
  
    

}
