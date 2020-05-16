//
//  ViewController.swift
//  Covid-19 Tracker
//
//  Created by Jean martin Kyssama on 18/04/2020.
//  Copyright © 2020 Jean martin Kyssama. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var globalDatabutton: UIButton!
    @IBOutlet weak var countryButton: UIButton!
    
    //MARK: - RELEVANT VARIABLES
    private let segueToRelevantDataIdentifier: String = "toGlobalData"
    private let segueToCountryVC: String = "toCountrySegue"
    private let covidApiUrl: String = "https://covid19.mathdro.id/api"
    var confirmedCasesInfo: String = ""
    var deathsInfo: String = ""
    var recoveriesInfo: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // on appelle cette fonction au chargement de l'application
        boutonArrondi()
        
    }
    
    //MARK: - Function qui donne un bouton arrondi
    func boutonArrondi() {
        globalDatabutton.layer.cornerRadius = 10
        globalDatabutton.layer.borderWidth = 2
        globalDatabutton.layer.borderColor = UIColor.systemBlue.cgColor
        //country data button
        countryButton.layer.cornerRadius = 10
        countryButton.layer.borderWidth = 2
        countryButton.layer.borderColor = UIColor.systemBlue.cgColor
    }
    //MARK: - PASS DATA TO 2nd VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToRelevantDataIdentifier {
            if let secondVC = segue.destination as? GlobalDataViewController {
                secondVC.confirmedCasesReceiver = confirmedCasesInfo
                secondVC.deathsReceiver = deathsInfo
                secondVC.recoveriesReceiver = recoveriesInfo
            }
        }
    }
    
    //MARK: - Boutton qui gere le passage au second VC
    @IBAction func boutonToGlobalData(_ sender: UIButton) {
        // on appelle la fonction http ici
        httpCall()
    }
    
    //MARK: - Bouton qui gere le segue vers country data
    @IBAction func buttonToCountryData(_ sender: UIButton) {
        print("it works")
        performSegue(withIdentifier: segueToCountryVC, sender: self)
    }
    
    
    //MARK: - Networking
    func httpCall() {
        //
        request(covidApiUrl, method: .get).responseJSON { (response) in
            if response.result.isSuccess {
                let globalDataJSON: JSON = JSON(response.result.value)
                //print(globalDataJSON)
                
                //on va extraire les differentes valeurs dont nous avons besoins
                //1. confirmed cases
                let confirmedCases = globalDataJSON["confirmed"]["value"].stringValue
                //print("There are currently \(confirmedCases) confirmed cases")
                //on affecte a la variable globale
                self.confirmedCasesInfo = confirmedCases
                //2 deaths
                let deaths = globalDataJSON["deaths"]["value"].stringValue
                self.deathsInfo = deaths
                // recoveries
                let recoveries = globalDataJSON["recovered"]["value"].stringValue
                //print("So far \(recoveries) persons have recovered")
                self.recoveriesInfo = recoveries
                
                //ensuite on fait le segue ici
                self.performSegue(withIdentifier: self.segueToRelevantDataIdentifier, sender: self)
            } else {
                fatalError("Failed to make HttpCall")
            }
        }
    }
    
    
    


}

