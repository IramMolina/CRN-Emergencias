//
//  SeleccionarEmergenciaViewController.swift
//  CRN Emergencias
//
//  Created by Diego Trujillo Norberto on 05/04/16.
//  Copyright © 2016 ITESM CEM. All rights reserved.
//

import UIKit

class SeleccionarEmergenciaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{

    @IBOutlet weak var otroTextField: UITextField!

    
    let arregloEmergencias = ["Alergias/Anafilaxia","Crisis asmática","Sangrado","Fracturas","Quemaduras","Atragantamiento/Asfixia","Emergencias Diabeticas", "Ataque de ansiedad","Lesiones en la cabeza","Infarto al corazón","Golpe de calor", "Hipotermia","Meningitis", "Envenenamiento/Sustancias peligrosas","Convulsiones/Epilepsia","Picadura/Mordedura","Torceduras/Esguince","Embolia cerebral","Inconsciente","Otro"]
    let arregloDescripciones = ["Lesión en los tejidos del cuerpo\ncausado por calor, sustancias químicas, electricidad, \netc ...","Descripción","Descripción","Descripción","Descripción","Descripción","Descripción","Descripción","Descripción","Descripción","Descripción","Descripción"]
    var emergenciaSeleccionada: String = "Null"
    
    // MARK: - Inicio de la Pantalla
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Permite quitar el teclado cuando se quita en algun lugar
        
       
        let preferenciasUsuario = NSUserDefaults.standardUserDefaults()
        preferenciasUsuario.setObject("default", forKey: "emergencia")
        preferenciasUsuario.synchronize()
        
        otroTextField.enabled = false
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
    }
    

 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
