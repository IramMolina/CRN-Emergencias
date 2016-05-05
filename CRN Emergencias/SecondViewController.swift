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
  
    
    let arrEmergencias = ["Alergias/Anafilaxia","Ataque de ansiedad","Atragantamiento/Asfixia","Convulsiones/Epilepsia","Quemaduras","Crisis asmática","Embolia cerebral", "Emergencias Diabéticas","Envenenamiento/sustancias peligrosas","Estado de choque","Fracturas", "Golpe de calor","Hipotermia", "Inconsciente y respira","Inconsciente y no respira","Infarto al corazón","Lesiones en la cabeza","Meningitis","Quemaduras","Sangrado","Torceduras y esguinces","Picaduras y mordeduras de insectos","Garrapatas","Picadura/mordedura de alacranes o arañas","Picadura de medusa","Mordedura de serpiente venenosa","Mordeduras de animales"];
    
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
        cell.textLabel?.textColor = UIColor.grayColor()
        
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let info = segue.destinationViewController as! InfoEmergencias
        info.emergencia = arrEmergencias[table.indexPathForSelectedRow!.row]
        
        //let indexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
        print(arrEmergencias[table.indexPathForSelectedRow!.row])
        segue.destinationViewController.title = arrEmergencias[table.indexPathForSelectedRow!.row]
        
    }
    

}

