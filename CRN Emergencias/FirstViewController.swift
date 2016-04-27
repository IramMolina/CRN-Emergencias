//
//  FirstViewController.swift
//  CRN Emergencias
//
//  Created by Diego Trujillo Norberto on 17/03/16.
//  Copyright © 2016 ITESM CEM. All rights reserved.
//

import UIKit
import CoreLocation

class FirstViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var longTapButton: ANLongTapButton!
    
    let administradorDeUbicacion = CLLocationManager()
    
    // MARK: - Variables de Ubicación
    var latitudUsuario: Double = 0.0
    var longitudUsuario: Double = 0.0
    
    var servicioUbicacionIniciado: Bool = false
    

    
    
    
    
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        // Ubicación
        self.administradorDeUbicacion.delegate = self
        self.administradorDeUbicacion.desiredAccuracy = kCLLocationAccuracyBest
        self.administradorDeUbicacion.requestWhenInUseAuthorization()
        
        
        if !servicioUbicacionIniciado {
            self.administradorDeUbicacion.startUpdatingLocation()
            servicioUbicacionIniciado = true
        }
        
        longTapButton.didTimePeriodElapseBlock = { () -> Void in
        
            let avisoImportancia = UIAlertController(title: "Aviso", message: "¿Está seguro que desea reporta una emergencia? Le recordamos que esta aplciación no es un juguete.", preferredStyle: .Alert)
            avisoImportancia.addAction(UIAlertAction(title: "Reportar", style: .Default, handler: { (UIAlertAction) -> Void in
                self.performSegueWithIdentifier("segueSeleccionarEmergencia", sender: self)
            }))
            avisoImportancia.addAction(UIAlertAction(title: "Cancelar", style: .Destructive, handler: nil))
            
            self.presentViewController(avisoImportancia, animated: true, completion: nil)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func BotonLlamar_Accion(sender: UIButton) {
        
        let phone = "tel://7225857373"
        let url : NSURL = NSURL(string:phone)!
        UIApplication.sharedApplication().openURL(url)
        
        
    }
    
    // MARK: - Auxiliares
    

    
    // MARK: - Métodos de Ubicación
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let ubicacion = locations.last
        
        let coordenadas = CLLocationCoordinate2D(latitude: ubicacion!.coordinate.latitude, longitude: ubicacion!.coordinate.longitude)
        
    
        
        let preferenciasUsuario = NSUserDefaults.standardUserDefaults()
        
        preferenciasUsuario.setObject(coordenadas.latitude, forKey: "latitud")
        preferenciasUsuario.setObject(coordenadas.longitude, forKey: "longitud")
        
        preferenciasUsuario.synchronize()
        

        
        self.administradorDeUbicacion.stopUpdatingLocation()
        
    }

    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error.localizedDescription)
    }

}

