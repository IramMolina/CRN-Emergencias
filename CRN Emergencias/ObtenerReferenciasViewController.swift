//
//  ObtenerReferenciasViewController.swift
//  CRN Emergencias
//
//  Created by Diego Trujillo Norberto on 05/04/16.
//  Copyright © 2016 ITESM CEM. All rights reserved.
//

import UIKit

class ObtenerReferenciasViewController: UIViewController {

    @IBOutlet weak var referenciasTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "BG3.jpg")!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func EmularEnvio(sender: AnyObject) {
        
        let preferenciasUsuario = NSUserDefaults.standardUserDefaults()
        
        let mensaje = "Se enviará:\nNombre: \(preferenciasUsuario.stringForKey("nombre")!) \(preferenciasUsuario.stringForKey("apellido")!)\nEmergencia: \(preferenciasUsuario.stringForKey("emergencia")!)\nCoordenadas: \(preferenciasUsuario.stringForKey("latitud")!) \(preferenciasUsuario.stringForKey("longitud")!)"
        
        let alerta = UIAlertController(title: "Confirmar envío", message:
            mensaje, preferredStyle: UIAlertControllerStyle.Alert)
        alerta.addAction(UIAlertAction(title: "Enviar", style: .Default,handler: nil))
        alerta.addAction(UIAlertAction(title: "Cancelar", style: .Cancel, handler: nil))
        
        self.presentViewController(alerta, animated: true, completion: nil)
        
        

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
