//
//  GlobalDataViewController.swift
//  Covid-19 Tracker
//
//  Created by Jean martin Kyssama on 18/04/2020.
//  Copyright © 2020 Jean martin Kyssama. All rights reserved.
//

import UIKit

class GlobalDataViewController: UIViewController {
    @IBOutlet weak var confirmedLabel: UILabel!
    @IBOutlet weak var deathsLabel: UILabel!
    @IBOutlet weak var recoveriesLabel: UILabel!
    
    //MARK: - Relevant variables
    var confirmedCasesReceiver = ""
    var deathsReceiver: String = ""
    var recoveriesReceiver: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if confirmedLabel.text != nil {
            confirmedLabel.text = confirmedCasesReceiver
            deathsLabel.text = deathsReceiver
            recoveriesLabel.text = recoveriesReceiver
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
