//
//  ObtenerReferenciasViewController.swift
//  CRN Emergencias
//
//  Created by Diego Trujillo Norberto on 05/04/16.
//  Copyright © 2016 ITESM CEM. All rights reserved.
//

import UIKit
import MessageUI

class ObtenerReferenciasViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var referenciasTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "BG3.jpg")!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func EmularEnvio(sender: AnyObject) {
        
        let preferenciasUsuario = NSUserDefaults.standardUserDefaults()
        
        let nombre = preferenciasUsuario.stringForKey("nombre")!
        let apellido = preferenciasUsuario.stringForKey("apellido")!
        let emergencia = preferenciasUsuario.stringForKey("emergencia")!
        let latitud = preferenciasUsuario.stringForKey("latitud")!
        let longitud = preferenciasUsuario.stringForKey("longitud")!
        let urlMaps = "http://maps.google.com/maps?q=\(latitud),\(longitud)"
        
        let mensaje = "Se enviará:\nNombre: \(nombre) \(apellido)\nEmergencia: \(emergencia)\nCoordenadas: \(latitud) \(longitud)"
        
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
        
        
        //https://docs.google.com/forms/d/1PhVKIBESG5KdAwErQpJCpCSkrcYEvDM-aPmmttJQxZw/formResponse
        //Nombre entry.865888786
        //Apellido entry.790203585
        //Emergencia entry.1100998756
        //Localizacion entry.794367441
        
        //Envio de datos a googly form
        let direccion = "https://docs.google.com/forms/d/1PhVKIBESG5KdAwErQpJCpCSkrcYEvDM-aPmmttJQxZw/formResponse"
        
        if let url = NSURL(string: direccion){
            let configuracion = NSURLSessionConfiguration.defaultSessionConfiguration()
            let sesion = NSURLSession(configuration: configuracion)
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            
            let cadenaDatos = "entry.865888786=\(nombre)&entry.790203585=\(apellido)&entry.1100998756=\(emergencia)&entry.794367441=\(urlMaps)"
            
            let cadenaAcentos = cadenaDatos.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            let datosBin = cadenaAcentos?.dataUsingEncoding(NSUTF8StringEncoding)
            let tarea = sesion.uploadTaskWithRequest(request, fromData: datosBin, completionHandler: { (datos, response, error) in
                //Success
                let cadena = NSString(data: datos!, encoding: NSUTF8StringEncoding)
                print(cadena)
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
        
        let mensaje = "Se enviará:\nNombre: \(nombre) \(apellido)\nEmergencia: \(emergencia)\nCoordenadas: \(urlMaps)"
        
        mailComposerVC.setToRecipients(["araizaga.yael@gmail.com"])
        mailComposerVC.setSubject("Prueba de correo")
        mailComposerVC.setMessageBody(mensaje, isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
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
