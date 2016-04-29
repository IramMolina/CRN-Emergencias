//
//  FirstViewController.swift
//  CRN Emergencias
//
//  Created by Diego Trujillo Norberto on 17/03/16.
//  Copyright © 2016 ITESM CEM. All rights reserved.
//

import UIKit
import CoreLocation

class FirstViewController: UIViewController, CLLocationManagerDelegate{

    @IBOutlet weak var longTapButton: ANLongTapButton!
    private var internet: Bool = false

    private let objetoLocationManager = CLLocationManager()
    private var posicion: CLLocation?
    private var naucalpan: Bool = false
 
    override func viewDidLoad() {
        self.checaInternet()
        
        self.configurarCoreLocation()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        longTapButton.didTimePeriodElapseBlock = { () -> Void in
            
            if(self.internet == true){
                self.checarNaucalapan()
                //CAMBIAR ANTES DE SHIPEAR !!!!!!!!!!!!
               // self.naucalpan = true
                ////ONDFOINDOANDAONDJANDOADNOADNAODNadn
                
                if(self.naucalpan == false){
                    self.showNaucalapanErrorAlert()
                }
                else{
                    let avisoImportancia = UIAlertController(title: "Aviso", message: "Se hace de su conocimiento que el envío de notificaciones falsas amerita un reporte ante el Ministerio Público y al enviar esta alerta se hace responsable de la veracidad del informe.",     preferredStyle: .Alert)
                    avisoImportancia.addAction(UIAlertAction(title: "Reportar", style: .Default, handler: { (UIAlertAction) -> Void in
                        self.performSegueWithIdentifier("segueSeleccionarEmergencia", sender: self)
                    }))
                    avisoImportancia.addAction(UIAlertAction(title: "Cancelar", style: .Destructive, handler: nil))
            
                    self.presentViewController(avisoImportancia, animated: true, completion: nil)
                }
                
            }
            else{
                
                let internetErrorAlert = UIAlertView(title: "No hay conexión a Internet", message: "Tu dispositivo no está conectado a Internet. Usa la opción de 'Llamar' para contactara a la Cruz Roja o conectate a Internet e intenta otra vez", delegate: self, cancelButtonTitle: "OK")
                internetErrorAlert.show()
                
                self.checaInternet()

            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func BotonLlamar_Accion(sender: UIButton) {
        
        let phone = "tel://55606899"
        let url : NSURL = NSURL(string:phone)!
        UIApplication.sharedApplication().openURL(url)
        
        
    }
    
    func checaInternet(){
        if Reach_ability.isConnectedToNetwork() == true {
            self.internet = true
        } else {
            self.internet = false
        }
    }
    
    // MARK: - Auxiliares
    
    func configurarCoreLocation(){
        objetoLocationManager.delegate = self
        objetoLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        objetoLocationManager.requestWhenInUseAuthorization()
    }
    // Autorización de Ubicación
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse || status == CLAuthorizationStatus.AuthorizedAlways{
            objetoLocationManager.startUpdatingLocation()
        }
        else{
            objetoLocationManager.stopUpdatingLocation()
            
            let alertaUbicacion = UIAlertController(title: "Aviso", message: "Se necesita habilitar el servicio de Ubicación para emitir la alerta", preferredStyle: .Alert)
            alertaUbicacion.addAction(UIAlertAction(title: "Aceptar", style: .Default, handler: nil))
            self.presentViewController(alertaUbicacion, animated: true, completion: nil)
            
        }
    }
    
    // Actualizar Ubicación
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!.coordinate
        posicion = locations.last!
        
        let preferenciasUsuario = NSUserDefaults.standardUserDefaults()
        
        preferenciasUsuario.setObject(location.latitude, forKey: "latitud")
        preferenciasUsuario.setObject(location.longitude, forKey: "longitud")
        
        preferenciasUsuario.synchronize()
        
        
        
        manager.stopUpdatingLocation()
        
        print("\(location)")
    }
    // Con error
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Falló geolocalización")
    }

    func checarNaucalapan(){
        let geocoder = CLGeocoder()
        
        //println("-> Finding user address...")
        
        geocoder.reverseGeocodeLocation(posicion!, completionHandler: {(placemarks, error)->Void in
            var placemark:CLPlacemark!
            
            if error == nil && placemarks!.count > 0 {
                placemark = placemarks![0] as CLPlacemark
                
                let municipio = placemark.locality!
                let minimuni = municipio.lowercaseString
                
                if minimuni.rangeOfString("naucalpan") == nil {
                    //self.showNaucalapanErrorAlert()
                    self.naucalpan = false
                }
                else{
                    self.naucalpan = true
                }
            }
        })
        
    }

    
    func showNaucalapanErrorAlert() {
        let naucalpanErrorAlert = UIAlertView(title: "Te encuentras fuera del municipio de Naucalpan", message: "Tu información no se puede enviar a la Cruz Roja de Naucalpan. \n\n Te recomendamos usar la opción de \"llamar\" para contactar a servicios de emergencia", delegate: self, cancelButtonTitle: "OK")
         
         naucalpanErrorAlert.show()
    }



}

