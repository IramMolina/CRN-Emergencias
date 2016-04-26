//
//  RegistroInformacionViewController.swift
//  CRN Emergencias
//
//  Created by Diego Trujillo Norberto on 05/04/16.
//  Copyright © 2016 ITESM CEM. All rights reserved.
//

import UIKit

class RegistroInformacionViewController: UIViewController{

    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var apellidoTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "quitarTeclado")
        self.view.addGestureRecognizer(tap)

        
    }
    
    func quitarTeclado(){
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        
    }
    
    @IBAction func botonEmpezar(sender: AnyObject) {
        
        let preferenciasUsuario = NSUserDefaults.standardUserDefaults()
        
        preferenciasUsuario.setObject(nombreTextField.text!, forKey: "nombre")
        preferenciasUsuario.setObject(apellidoTextField.text!, forKey: "apellido")
        
        preferenciasUsuario.synchronize()
        
        let avisoImportancia = UIAlertController(title: "Aviso", message: "Esta aplicación es delicada, así que no bromas.", preferredStyle: .Alert)
        avisoImportancia.addAction(UIAlertAction(title: "Aceptar", style: .Default, handler: { (UIAlertAction) -> Void in
            self.performSegueWithIdentifier("inicio", sender: self)
        }))
        avisoImportancia.addAction(UIAlertAction(title: "Cancelar", style: .Destructive, handler: { (UIAlertAction) -> Void in
            UIControl().sendAction(Selector("suspend"), to: UIApplication.sharedApplication(), forEvent: nil)
        }))
        
        self.presentViewController(avisoImportancia, animated: true, completion: nil)
        
        
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
