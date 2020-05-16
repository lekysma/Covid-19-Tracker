//
//  CountryDatamodel.swift
//  Covid-19 Tracker
//
//  Created by Jean martin Kyssama on 11/05/2020.
//  Copyright © 2020 Jean martin Kyssama. All rights reserved.
//

import Foundation

class CountryDataModel {
    let countryName: String
    let casesData: String
    let deathsData: String
    let recoveriesData: String
    
    init(country: String, cases: String, deaths: String, recoveries: String) {
        
        countryName = country
        casesData = cases
        deathsData = deaths
        recoveriesData = recoveries
        
    }
}
