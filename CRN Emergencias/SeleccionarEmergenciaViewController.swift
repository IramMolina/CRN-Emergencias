//
//  SeleccionarEmergenciaViewController.swift
//  CRN Emergencias
//
//  Created by Diego Trujillo Norberto on 05/04/16.
//  Copyright © 2016 ITESM CEM. All rights reserved.
//

import UIKit

class SeleccionarEmergenciaViewController: UIViewController{


    @IBOutlet weak var descripcionLabel: UILabel!
    
    let arregloEmergencias = ["Alergias/Anafilaxia","Crisis asmática","Sangrado","Fracturas","Quemaduras","Atragantamiento/Asfixia","Emergencias Diabeticas", "Ataque de ansiedad","Lesiones en la cabeza","Infarto al corazón","Golpe de calor", "Hipotermia","Meningitis", "Envenenamiento/Sustancias peligrosas","Convulsiones/Epilepsia","Picadura/Mordedura","Torceduras/Esguince","Embolia cerebral","Inconsciente"]
    let arregloDescripciones = ["Lesión en los tejidos del cuerpo\ncausado por calor, sustancias químicas, electricidad, \netc ...","Descripción","Descripción","Descripción","Descripción","Descripción","Descripción","Descripción","Descripción","Descripción","Descripción","Descripción"]
    var emergenciaSeleccionada: String = "Null"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
       
        let preferenciasUsuario = NSUserDefaults.standardUserDefaults()
        preferenciasUsuario.setObject("default", forKey: "emergencia")
        preferenciasUsuario.synchronize()
    }
    
        
    // MARK: - Funciones PeekerView DATASOURCE
 
    
    // MARK: - Funciones PeekerView DELEGADO

    
    @IBAction func EnviarInformacion(sender: AnyObject) {
        print("FIN")
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
