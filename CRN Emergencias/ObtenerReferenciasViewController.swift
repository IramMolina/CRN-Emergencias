//
//  ObtenerReferenciasViewController.swift
//  CRN Emergencias
//
//  Created by Diego Trujillo Norberto on 05/04/16.
//  Copyright © 2016 ITESM CEM. All rights reserved.
//

import UIKit
import MessageUI
import CoreLocation
import MapKit

class ObtenerReferenciasViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, MFMailComposeViewControllerDelegate, UITextViewDelegate {

    // MARK: - Outlets y Objetos
    @IBOutlet weak var referenciasTextView: UITextView!
    @IBOutlet weak var mapaMapKitView: MKMapView!
    

    // MARK: - Variables
    private let objetoLocationManager = CLLocationManager()
    private var textViewEditando = false
    private var referenciaDada = false
    private var referenciaString: String = ""
    private var posicion: CLLocation?
    
    // MARK: - Config Inicial
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // CORE LOCATION
        self.configurarCoreLocation()
        
        // DISMISS KEYBOARD
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ObtenerReferenciasViewController.quitarTeclado))
        self.view.addGestureRecognizer(tap)
       
        
    }
    
    func quitarTeclado(){
        self.view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    // MARK: - Funciones CoreLocation DELEGADO
    
    // Configurar
    func configurarCoreLocation(){
        objetoLocationManager.delegate = self
        objetoLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        objetoLocationManager.requestWhenInUseAuthorization()
    }
    // Autorización de Ubicación
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse || status == CLAuthorizationStatus.AuthorizedAlways{
            objetoLocationManager.startUpdatingLocation()
            mapaMapKitView.showsUserLocation = true
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
        
        mapaMapKitView.setCenterCoordinate(location, animated: false)
        mapaMapKitView.setRegion(MKCoordinateRegion(center: location,span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta:  0.01)), animated: false)
        
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
    
    // MARK: - Funciones MapKit DELEGADO
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
       //print("Exito")
    }
    
    
    // MARK: - Funciones TextView - DELEGADO
    func textViewDidBeginEditing(textView: UITextView) {
        if !textViewEditando {
            textViewEditando = true
            referenciasTextView.text = ""
            referenciasTextView.textColor = UIColor.darkGrayColor()
        }
    }
    
    // Quitar teclado cuando se de en Aceptar
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        if textView.text == "" {
            referenciaString = "Ninguna"
        }
        else{
            referenciaString = textView.text
        }
        
        print(referenciaString)
        
        if text == "\n" {
            
            // Asignar el valor del string
            
            textView.resignFirstResponder()
            return false
        }
        
        return true
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text == "" {
            referenciaString = "Ninguna"
        }
        else{
            referenciaString = textView.text
        }
        
        print(referenciaString)
    }
    
    // MARK: - Funciones Enviar
    
    
    @IBAction func EmularEnvio(sender: AnyObject) {
        
        let preferenciasUsuario = NSUserDefaults.standardUserDefaults()
        
        let nombre = preferenciasUsuario.stringForKey("nombre")!
        let apellido = preferenciasUsuario.stringForKey("apellido")!
        let emergencia = preferenciasUsuario.stringForKey("emergencia")!
        let latitud = preferenciasUsuario.stringForKey("latitud")!
        let longitud = preferenciasUsuario.stringForKey("longitud")!
        let urlMaps = "http://maps.google.com/maps?q=\(latitud),\(longitud)"
        let telefono = preferenciasUsuario.stringForKey("telefono")!

        
        let mensaje = "Se enviará:\nNombre: \(nombre) \(apellido)\nEmergencia: \(emergencia)\nCoordenadas: \(latitud) \(longitud)"
        print(mensaje)
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
            
        }
        /*
        let alerta = UIAlertController(title: "Confirmar envío", message:
            mensaje, preferredStyle: UIAlertControllerStyle.Alert)
        alerta.addAction(UIAlertAction(title: "Enviar", style: .Default,handler: nil))
        alerta.addAction(UIAlertAction(title: "Cancelar", style: .Cancel, handler: nil))
        */
        
        
        //https://docs.google.com/forms/d/1RtS7Vpq-CWJGOLHzE5AY57Hc-MSZ-InCneMSZqRYtsk/formResponse
        //Nombre entry.972638277
        //Apellido entry.407116933
        //Emergencia entry.310819800
        //Localizacion entry.993735022
        //Telefono entry.1209442796
        //Referencias entry.1664264665
        
        //Envio de datos a googly form
        let direccion = "https://docs.google.com/forms/d/1RtS7Vpq-CWJGOLHzE5AY57Hc-MSZ-InCneMSZqRYtsk/formResponse"
        
        if let url = NSURL(string: direccion){
            let configuracion = NSURLSessionConfiguration.defaultSessionConfiguration()
            let sesion = NSURLSession(configuration: configuracion)
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            
            let cadenaDatos = "entry.972638277=\(nombre)&entry.407116933=\(apellido)&entry.310819800=\(emergencia)&entry.993735022=\(urlMaps)&entry.1209442796=\(telefono)&entry.1664264665=\(self.referenciasTextView.text)"
            
            let cadenaAcentos = cadenaDatos.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            let datosBin = cadenaAcentos?.dataUsingEncoding(NSUTF8StringEncoding)
            let tarea = sesion.uploadTaskWithRequest(request, fromData: datosBin, completionHandler: { (datos, response, error) in
                //Success
                //let cadena = NSString(data: datos!, encoding: NSUTF8StringEncoding)
                //print(cadena)
            })
            tarea.resume()
            
        
        }
        
        //self.presentViewController(alerta, animated: true, completion: nil)

        
        

    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        let preferenciasUsuario = NSUserDefaults.standardUserDefaults()
        
        let nombre = preferenciasUsuario.stringForKey("nombre")!
        let apellido = preferenciasUsuario.stringForKey("apellido")!
        let emergencia = preferenciasUsuario.stringForKey("emergencia")!
        let latitud = preferenciasUsuario.stringForKey("latitud")!
        let longitud = preferenciasUsuario.stringForKey("longitud")!
        let urlMaps = "http://maps.google.com/maps?q=\(latitud),\(longitud)"
        let telefono = preferenciasUsuario.stringForKey("telefono")!
        let referencia = self.referenciasTextView.text

        
        let mensaje = "Se enviará:\nNombre: \(nombre) \(apellido)\nEmergencia: \(emergencia)\nTelefono: \(telefono)\nCoordenadas: \(urlMaps)\nReferencias: \(referencia)"
        
        mailComposerVC.setToRecipients(["urgencias.crn.form@gmail.com"])
        mailComposerVC.setSubject("Se ha activado el boton de emergencia")
        mailComposerVC.setMessageBody(mensaje, isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        
        let sendMailErrorAlert = UIAlertView(title: "No se pudo enviar el mail", message: "Tu dispositivo no pudo enviar el e-mail.  Por favor revisa la configuración de mail e intenta de nuevo.", delegate: self, cancelButtonTitle: "OK")
            sendMailErrorAlert.show()
        
        //CUando falla  segue()
        self.performSegueWithIdentifier("push", sender: self)
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        //controller.dismissViewControllerAnimated(true, completion:)
        self.navigationController?.dismissViewControllerAnimated(true, completion: { 
            self.performSegueWithIdentifier("push", sender: self)
            
        })
        //cuando se envia segue()
        //self.performSegueWithIdentifier("push", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "push"){
        let info = segue.destinationViewController as! InfoEmergencias
        
        
        let preferenciasUsuario = NSUserDefaults.standardUserDefaults()
        let emergencia = preferenciasUsuario.stringForKey("emergencia")!
        
        
        
        info.emergencia = emergencia
        
        //let indexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
        segue.destinationViewController.title = emergencia
        }
        
    }

}
