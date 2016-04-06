//
//  SeleccionarEmergenciaViewController.swift
//  CRN Emergencias
//
//  Created by Diego Trujillo Norberto on 05/04/16.
//  Copyright © 2016 ITESM CEM. All rights reserved.
//

import UIKit

class SeleccionarEmergenciaViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {


    @IBOutlet weak var descripcionLabel: UILabel!
    
    let arregloEmergencias = ["Alergias/Anafilaxia","Crisis asmática","Sangrado","Fracturas","Quemaduras","Atragantamiento/Asfixia","Emergencias Diabeticas", "Ataque de ansiedad","Lesiones en la cabeza","Infarto al corazón","Golpe de calor", "Hipotermia","Meningitis", "Envenenamiento/Sustancias peligrosas","Convulsiones/Epilepsia","Picadura/Mordedura","Torceduras/Esguince","Embolia cerebral","Inconsciente"]
    let arregloDescripciones = ["Lesión en los tejidos del cuerpo\ncausado por calor, sustancias químicas, electricidad, \netc ...","Descripción","Descripción","Descripción","Descripción"]
    var emergenciaSeleccionada: String = "Null"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "BG3.jpg")!)
        let preferenciasUsuario = NSUserDefaults.standardUserDefaults()
        preferenciasUsuario.setObject("default", forKey: "emergencia")
        preferenciasUsuario.synchronize()
    }
    
        
    // MARK: - Funciones PeekerView DATASOURCE
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arregloEmergencias.count
    }
        
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arregloEmergencias[row]
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: arregloEmergencias[row], attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
        return attributedString
    }
    
    // MARK: - Funciones PeekerView DELEGADO
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        emergenciaSeleccionada = arregloEmergencias[row]
        descripcionLabel.text = arregloDescripciones[row]
        
        let preferenciasUsuario = NSUserDefaults.standardUserDefaults()
        
        preferenciasUsuario.setObject(emergenciaSeleccionada, forKey: "emergencia")

        preferenciasUsuario.synchronize()
        
        print(emergenciaSeleccionada)
    }
    
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
