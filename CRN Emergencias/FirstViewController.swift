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

    @IBOutlet weak var BotonEmergencia_Outlet: UIButton!
    
    let administradorDeUbicacion = CLLocationManager()
    
    // MARK: - Variables de Ubicación
    var latitudUsuario: Double = 0.0
    var longitudUsuario: Double = 0.0
    
    
    @IBAction func onPayNowButtonTapped(longTapButton: ANLongTapButton)
    {
        longTapButton.didTimePeriodElapseBlock = { () -> Void in
            let alert = UIAlertController(title: "Payment", message: "Payment has been made.", preferredStyle:   UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.administradorDeUbicacion.delegate = self
        
        self.administradorDeUbicacion.desiredAccuracy = kCLLocationAccuracyBest
        
        self.administradorDeUbicacion.requestWhenInUseAuthorization()
        
        self.administradorDeUbicacion.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func BotonLlamar_Accion(sender: UIButton) {
        
        let phone = "tel://7225857373";
        let url : NSURL = NSURL(string:phone)!;
        UIApplication.sharedApplication().openURL(url);
        
        
    }
    

    
    
    // MARK: - Métodos de Ubicación
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let ubicacion = locations.last
        
        let coordenadas = CLLocationCoordinate2D(latitude: ubicacion!.coordinate.latitude, longitude: ubicacion!.coordinate.longitude)
        
        self.latitudUsuario = coordenadas.latitude
        self.longitudUsuario = coordenadas.longitude
        
        print(coordenadas)
        
        self.administradorDeUbicacion.stopUpdatingLocation()
        
        
    }

    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error.localizedDescription)
    }

}

