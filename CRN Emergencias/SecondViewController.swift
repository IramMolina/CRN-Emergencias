//
//  SecondViewController.swift
//  CRN Emergencias
//
//  Created by Diego Trujillo Norberto on 17/03/16.
//  Copyright © 2016 ITESM CEM. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var table: UITableView!
  
    
    let arrEmergencias = ["Alergias/Anafilaxia","Crisis asmática","Sangrado","Fracturas","Quemaduras","Atragantamiento/Asfixia","Emergencias Diabeticas", "Ataque de ansiedad","Lesiones en la cabeza","Infarto al corazón","Golpe de calor", "Hipotermia","Meningitis", "Envenenamiento/Sustancias peligrosas","Convulsiones/Epilepsia","Picadura/Mordedura","Torceduras/Esguince","Embolia cerebral","Inconsciente"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView:	UITableView)	->	Int {
        return	1
    }
    func tableView(tableView:	UITableView,	numberOfRowsInSection section:	Int)	->	Int {
        return self.arrEmergencias.count
    }
    func tableView(tableView:	UITableView,	cellForRowAtIndexPath indexPath:	NSIndexPath)	->	UITableViewCell {
        let celda = tableView.dequeueReusableCellWithIdentifier("celdaID", forIndexPath: indexPath)
        celda.textLabel!.text =	self.arrEmergencias[indexPath.row]
        return celda
    }
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = .clearColor()
        cell.textLabel?.textColor = UIColor.whiteColor()
    }
    
    

}

