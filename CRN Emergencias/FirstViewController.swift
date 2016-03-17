//
//  FirstViewController.swift
//  CRN Emergencias
//
//  Created by Diego Trujillo Norberto on 17/03/16.
//  Copyright © 2016 ITESM CEM. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var BotonEmergencia_Outlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        BotonEmergencia_Outlet.tintColor = UIColor.redColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func BotonLlamar_Accion(sender: UIButton) {
        
        let phone = "tel://7225857373";
        let url : NSURL = NSURL(string:phone)!;
        UIApplication.sharedApplication().openURL(url);
        
    }


}

