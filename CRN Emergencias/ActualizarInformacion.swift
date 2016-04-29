//
//  ActualizarInformacion.swift
//  CRN Emergencias
//
//  Created by Andrea Margarita Pérez Barrera on 28/04/16.
//  Copyright © 2016 ITESM CEM. All rights reserved.
//

import UIKit

class ActualizarInformacion: UIViewController {
    @IBOutlet weak var nombreTextField: UITextField!

    @IBOutlet weak var telefonoTextField: UITextField!
    @IBOutlet weak var apellidosTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegistroInformacionViewController.quitarTeclado))
        self.view.addGestureRecognizer(tap)
        
        let preferenciasUsuario = NSUserDefaults.standardUserDefaults()
        nombreTextField.placeholder = preferenciasUsuario.objectForKey("nombre")?.description
        apellidosTextField.placeholder = preferenciasUsuario.objectForKey("apellido")?.description
        telefonoTextField.placeholder = preferenciasUsuario.objectForKey("telefono")?.description
    }

    

    func quitarTeclado(){
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        
    }
    
    @IBAction func Actualizar(sender: AnyObject) {
        
        
        if(nombreTextField.text! == "" || apellidosTextField.text! == "" || telefonoTextField.text! == ""){
            let avisoIncompleto = UIAlertController(title: "Aviso", message: "La información esta incompleta. Llene con la información solicitada", preferredStyle: .Alert)
            avisoIncompleto.addAction(UIAlertAction(title: "Aceptar", style: .Default, handler: { (UIAlertAction) -> Void in
            }))
            nombreTextField.text! = ""
            apellidosTextField.text! = ""
            telefonoTextField.text! = ""
            self.presentViewController(avisoIncompleto, animated: true, completion: nil)
            
        }
        else{
            
            let preferenciasUsuario = NSUserDefaults.standardUserDefaults()
            
            preferenciasUsuario.setObject(nombreTextField.text!, forKey: "nombre")
            preferenciasUsuario.setObject(apellidosTextField.text!, forKey: "apellido")
            preferenciasUsuario.setObject(telefonoTextField.text!, forKey: "telefono")
            
            preferenciasUsuario.synchronize()

    }
    }

}
