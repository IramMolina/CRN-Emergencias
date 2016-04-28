//
//  SeleccionarEmergenciaViewController.swift
//  CRN Emergencias
//
//  Created by Diego Trujillo Norberto on 05/04/16.
//  Copyright © 2016 ITESM CEM. All rights reserved.
//

import UIKit

class SeleccionarEmergenciaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{

    // MARK: - Outlets
    @IBOutlet weak var otroTextField: UITextField!
    @IBOutlet weak var emergenciasTableView: UITableView!

    // MARK: - Variables
    let arregloEmergencias = ["Alergias/Anafilaxia","Crisis asmática","Sangrado","Fracturas","Quemaduras","Atragantamiento/Asfixia","Emergencias Diabeticas", "Ataque de ansiedad","Lesiones en la cabeza","Infarto al corazón","Golpe de calor", "Hipotermia","Meningitis", "Envenenamiento/Sustancias peligrosas","Convulsiones/Epilepsia","Picadura/Mordedura","Torceduras/Esguince","Embolia cerebral","Inconsciente","Otro"]

    var emergenciaSeleccionada: String = "Alergias/Anafilaxia"
    
    // MARK: - Inicio de la Pantalla
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Permite quitar el teclado cuando se quita en algun lugar
        
       // Valor temporal para la emergencia seleccionada
        let preferenciasUsuario = NSUserDefaults.standardUserDefaults()
        preferenciasUsuario.setObject(arregloEmergencias[0], forKey: "emergencia")
        preferenciasUsuario.synchronize()
        
        // Seleccionar el primer elemento
        emergenciasTableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: false, scrollPosition: .Top)
        
        // Desahbilitar el textField que contiene la emergencia seleccionada
        otroTextField.text = arregloEmergencias[0]
        otroTextField.enabled = false
    }
    
    // MARK: - Funciones de Interfaz
    // Cancelar el reporte
    @IBAction func cancelarReporte(sender: AnyObject) {
        
        let alertaSalida = UIAlertController(title: "Salir", message: "¿Desea cancelar el reporte de emergencia?", preferredStyle: .Alert)
        
        alertaSalida.addAction(UIAlertAction(title: "Permanecer", style: .Default, handler: nil))
        alertaSalida.addAction(UIAlertAction(title: "Salir", style: .Destructive, handler: { (UIAlertAction) in
            self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alertaSalida, animated: true, completion: nil)
        
    }
    
    // MARK: - Funciones Auxiliares
    func quitarTeclado(){
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true;
    }
        
    // MARK: - Funciones TableView DATASOURCE
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arregloEmergencias.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCellWithIdentifier("celda")
        celda!.textLabel?.text = arregloEmergencias[indexPath.row]
        
        return celda!
    }
    
    // MARK: - Funciones TableView DELEGADO
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if(arregloEmergencias[indexPath.row] == "Otro"){
            otroTextField.enabled = true
            otroTextField.text = ""
        }
        else{
            otroTextField.enabled = false
            otroTextField.text = arregloEmergencias[indexPath.row]
        }
        
        emergenciaSeleccionada = arregloEmergencias[indexPath.row]
    }
    

 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
 
        if emergenciaSeleccionada == "Otro"{
            emergenciaSeleccionada = otroTextField.text!
        }
        
        let preferenciasUsuario = NSUserDefaults.standardUserDefaults()
        preferenciasUsuario.setObject(emergenciaSeleccionada, forKey: "emergencia")
        preferenciasUsuario.synchronize()
    }
 

}
