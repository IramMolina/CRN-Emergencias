//
//  InfoEmergencias.swift
//  CRN Emergencias
//
//  Created by Andrea Margarita Pérez Barrera on 26/04/16.
//  Copyright © 2016 ITESM CEM. All rights reserved.
//

//import Foundation

import UIKit


private let reuseIdentifier = "Cell"

class InfoEmergencias: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //variable de instancia
    internal var emergencia = ""
    internal var numEmergencia = 0
    
    @IBOutlet weak var table: UITableView!
    //@IBOutlet weak var imageNum: UIImageView!

    
    let arrPasos = [["La persona puede desarrollar una erupción cutánea, picazón o hinchazón en sus manos, pies o cara. Su respiración puede ser más lenta. Puede ocurrir vómito y diarrea. Causas comunes de una reacción alérgica son el polen, piquetes de insectos, látex y algunos productos alimenticios, como nueces o productos lácteos."
,"Si la persona sufre de anafilaxia o problemas para respirar, llame a la Cruz Roja. Si la persona conoce que padece reacciones anafilácticas (problemas respiratorios, shock o cambios en su estado mental) llame inmediatamente a la Cruz Roja o pida a alguien más que lo haga.","Tranquilice frecuentemente al paciente al paciente en lo que llega la ambulancia."],["Demuestre que usted está escuchando a la persona y con calma pregunte cómo puede ayudar. Usted debe tratar de establecer la confianza mostrándole respeto.","Sea considerado de o que está pasando a su alrededor y lo que necesitan. Recuerde que las personas pueden tener dificultades para hacerle saber lo que necesitan.","Es posible que la persona se encuentre hiperventilando o respirando muy rápido, esto producirá que las manos y la cara se le duerman, estos síntomas se revertirán si respira normalmente. Esta condición es muy común, tranquilice a la persona e intente que respire de una forma pausada y controlada. Se sentirá mucho mejor si logra esto."],["Golpee firmemente en la espalda entre los omóplatos 5 veces para desalojar el objeto. A continuación, dar 5 compresiones abdominales rápidas. Esto crea una fuerte vibración y presión en la vía aérea, que a menudo es suficiente para eliminar el atragantamiento. En cuanto el objeto desobstruya la vía aérea podrá respirar de nuevo.","Llame a la Cruz Roja si el nivel de conciencia está alterado, la voz cambia, si no se ha podido despejar la vía aérea o si está preocupado."],["No los sujete, pero sí ponga una almohada o algo de ropa bajo su cabeza, para protegerlos de golpes. Si le es posible sostenga gentilmente su cabeza evitando que los movimientos hagan que la golpee contra el suelo. No introduzca ningún objeto en su boca.","Después de la convulsión, gire a la persona de lado con la cabeza inclinada hacia atrás. Esto permitirá que siga respirando y permitirá que cualquier fluido drene por la boca.","La persona puede tardar unos minutos en reaccionar, no se alarme, esto es normal. Con el paso del tiempo la persona recobrará todas sus facultades.","Si es posible investigue las posibles causas de las convulsiones. Si se desconoce la causa o fue por un golpe en la cabeza llame a la Cruz Roja o pida que alguien más lo haga."],
                    ["Ayude a la persona a sentarse en una posición cómoda y ayude en la administración de su medicamento. Usar un inhalador relaja los músculos, permitiendo abrir las vías aéreas y ayudando a la persona a respirar.","Tranquilice a la persona, si la crisis se vuelve severa, no cuenta con el medicamento o no mejora con el medicamento, llame a la Cruz Roja o pida que alguien más lo haga."],["Cara: ¿Hay debilidad en algún lugar de la cara? Brazos: ¿Pueden levantar ambos brazos?  Habla: ¿Se entiende claramente lo que dicen? Las embolias cerebrales son causadas por una interrupción de la irrigación de la sangre en el cerebro. Parte del cerebro se daña y esto puede afectarla apariencia de la persona, funciones corporales, habla y vista. ","Llame de inmediato a la Cruz Roja o pida que alguien más lo haga. Una embolia necesita atención médica inmediata. Entre más pronto reciba la ayuda la persona, será menor el daño que le puede ocasionar.","Hable con la persona para darle confianza mientras espera a la ambulancia."],
                    ["En caso de hipoglicemia (baja de azúcar) Dele algo que contenga azúcar, como tabletas de azúcar, jugo de naranja, el azúcar que contiene el chocolate o una bebida no dietética. Si la persona ya está inconsciente o no está segura de poder tragar NO INTENTE darle nada por la boca ya que puede bloquear la vía aérea.","Tranquilice a la persona, Llame a la Cruz Roja en caso de duda o que no haya mejoría, tenga dificultad para respirar o pierda la consciencia."],["Asegúrese qué, cuándo, y qué cantidad fue lo que tomó. Los servicios de emergencia querrán saber ésta información. Si fue algún tipo de medicamento, guarde la envoltura del mismo, así como la caja.","Llame al centro de información toxicológica. Marque a la Cruz Roja si caen inconscientes, tienen un cambio de carácter, tienen dificultad para respirar o si usted cree que son suicidas. ","No haga que la persona vomite o trate de darle algo de tomar a menos que se lo haya indicado el centro de información toxicológica.  Si usted les provoca el vómito, podría causar un mayor daño a su garganta o bloquear la vía aérea."],
                    ["Busque lo siguiente para determinar si alguien está en estado de choque: Desasosiego o irritabilidad, nausea o vómito, somnolencia, confusión o pérdida de consciencia, piel pálida, fría o húmeda. Pueden llegar a respirar rápidamente y tener una frecuencia cardiaca elevada.","Recuéstelos totalmente. ","Controle cualquier hemorragia externa.","Evite que la persona esté fría o muy caliente.","No les de nada de comer o beber.","Llame a la Cruz Roja o pida que alguien más lo haga."],["Aliente a la persona a sujetar la lesión con sus propias manos o utilice un cojín u objeto para prevenir movimientos innecesarios. Sujetar la lesión puede ayudar a disminuir el dolor y prevenir otros daños.","Si el área lesionada está muy deformada, existe mucho dolor o se necesita transportar, llame a la Cruz Roja o pida que alguien más lo haga.","Asegúrese de que la lesión esté inmovilizada hasta que la ayuda llegue."],
                    ["La piel de la persona puede estar caliente o roja y también puede estar seca o húmeda, ya que puede estar experimentando cambios en la consciencia, así como vómito y una temperatura corporal alta. ","Llame a la Cruz Roja o pida a alguien más que lo haga.","Mueva a la persona a un lugar fresco. Retire o afloje la ropa apretada y aplique paños o toallas húmedas y frías en la piel. Ventile a la persona. Si está consciente, dar pequeñas cantidades de agua fresca para beber. Asegúrese de que beba lentamente.","Si es necesario, continúe el enfriamiento mediante la aplicación de hielo o compresas frías envueltas en un paño para las muñecas, los tobillos, la ingle, el cuello y las axilas."],["El ambiente suele ser frío, pero una persona puede desarrollar hipotermia en un ambiente cálido, también. La persona puede estar temblado, pálida y fría al tacto. Tambien puede estar desorientada. ","Llame a la Cruz Roja lo antes posible o pida a alguien más que lo haga.","Calentar a la persona poco a poco, estando al pendiente de sus necesidades. Usted puede hacerlos entrar en calor envolviéndolos en una manta y dando bebidas calientes y alimentos con alto contenido energético."],
                    ["Cheque la vía aérea inclinando la cabeza hacia atrás y buscando respiraciones. Observe el pecho para ver si hay movimientos mientras buscamos las respiraciones.","Coloque a la persona de lado e incline la cabeza hacia atrás ","Llame de inmediato a la Cruz Roja o pida que alguien más lo haga."],["Cheque la respiración por medio de la inclinación de la cabeza hacia atrás y busque inhalaciones y expiraciones durante al menos 5 segundos. ","Llame a la Cruz Roja lo antes posible o pida que alguien más lo haga. Si siente respiraciones vaya a Inconsciente y respira en la sección de “¿Qué hacer?”.","Si no siente respiraciones comience con las compresiones. Coloque el talón de la mano en el centro del pecho y el talón de la otra mano sobre la que está colocada en el pecho entrelazando los dedos de las manos. ","Presione firmemente hacia abajo en el centro del pecho a la altura de los pezones, se debe de comprimir al menos un tercio del tamaño de tórax.","Presione al ritmo de 100 compresiones por minuto, hasta que llegue la ayuda."],
                    ["La persona puede tener dolor persistente de pecho o malestar inexplicable aislado en los brazos, cuello, mandíbula, espalda o estómago.","Llame a la Cruz Roja o pida a alguien más que lo haga.","Dele una aspirina, siempre y cuando no sea alérgico. Lo mejor es una que no sea entérica (esté recubierta).","Asegúrese de que esté en una posición cómoda para el (por ejemplo, sentarse en el suelo, apoyado contra una pared o una silla).","Tranquilice a la persona y brinde el apoyo necesario en lo que espera la ambulancia."],["Sugiérales descansar y aplique una compresa fría en el golpe.","Si la persona está confundida, somnolienta, vomita o la caída fue de más de dos veces su altura, llame a la Cruz Roja o consiga que alguien más lo haga. No permita que se duerma ya que esto impedirá evaluar su estado neurológico."],
                    ["La persona puede llegar a quejarse de sentir rigidez en el cuello, también podría presentar síntomas como de gripa, dolor muscular y de articulaciones, dolor de cabeza, aumento en la temperatura corporal y sensibilidad a la luz. Otros síntomas incluyen pies y manos frías, dolor de articulaciones, somnolencia y vómito. Una persona con meningitis, puede tener uno o varios síntomas e irse desarrollando conforme avanza la afección.","Cuando observe estos síntomas llame a la Cruz Roja o pida que alguien más lo haga. ","Esté con el paciente, tranquilizándolo y mostrándole su apoyo en lo que llega la ambulancia."],["Enfríe la quemadura al chorro de agua corriente por 10 minutos. Mientras más rápido una quemadura se enfríe menor será el impacto de la lesión. ","Si la quemadura requiere atención médica adicional, cubra holgadamente la quemadura con una envoltura de plástico o una bolsa de plástico limpia. De lo contrario, no necesitará cubierta de plástico. ","Si es necesario llame a la Cruz Roja o pida a alguien más que lo haga."],
                    ["Aplique presión en la herida con lo que tenga disponible para detener o disminuir el flujo de la sangre.","Si es sangrado es severo, llame a la Cruz Roja tan pronto sea posible o pida que alguien más lo haga.","Mantenga presionada la herida hasta que la ayuda llegue. "],["Recordar DICE: Descansar, Inmovilizar, Colocar frío y Elevar. Esto es para el cuidado de heridas en los músculos, huesos y articulaciones. ","Descansar. No se debe mover ni esforzar el área herida.","Inmovilizar. Se debe estabilizar el área herida en la posición en la que se encontró. Nunca intente forzar la articulación para lograr otra posición.","Colocar frío. Esto reducirá el dolor y la inflamación. ","Elevar. Elevar la parte lesionada únicamente si esto no causa más dolor.","No administre un medicamento contra el dolor. Esto podría enmascarar una lesión más importante. Si el dolor no cede, llame a la Cruz Roja o pida que alguien más lo haga. Si está en posibilidad de transportar a un hospital al paciente, hágalo usted mismo."],
                    ["Una persona que fue mordida o picadura sentirá dolor. Busque por marcas de la mordedura o piquete, inflamación o sangrado.","Remueva el aguijón raspando con una superficie plana como la de una tarjeta de crédito.","De otra manera cuidadosamente remuevalo con unas pinzas, asegurándose de haber sujetado la base del aguijón para evitar apretarlo y que expanda más el veneno.","Lave la herida con agua y jabón cubriendola con gasas y aplique hielo o una compresa fría.","Si la persona tiene alguna alergia o alguna reacción anafiláctica llame a la Cruz Roja o pida que alguien más lo haga. "],["Sujete las garrapatas con pinzas de punta fina sin raspar cerca de la piel y tire firmemente.","No intente quemar la garrapata o aplicar vaselina o esmalte de uñas.","Lave el área  mordida con jabón y agua.","Aplicar antiséptico o antibiótico triple en ungüento."],
                    ["Llame a la Cruz Roja si usted sospecha que una persona ha sido mordida por una viuda negra o araña reclusa parda, picada por un alacrán o tiene una reacción alérgica grave.","Lave bien la herida.","Si cuenta con una pomada antibiótica aplíquela y vende la herida.","Aplique hielo o una compresa fría en el área para reducir el dolor y la hinchazón.","Llame a la Cruz roja o pida que alguien más lo haga. Si transporta a la persona a un centro médico, mantenga elevada el área de la mordedura."],["Una persona con picadura de medusa se debe salir del agu tan rápido como sea posible.","Riegue el área de la picadura con grandes cantidades de vinagre durante al menos 30 segundos. Si el vinagre no está disponible, pruebe a utilizar pasta de bicarbonato de sodio. No toque el área afectada sin guantes o protección ya que puede lastimarse usted también. ","Cuando se detenga el escozor, atienda el dolor con inmersión del área afectada en agua caliente. Si es posible haga que la persona tome una ducha caliente durante 20 minutos.","Llame a la Cruz roja si la persona comienza a tener problemas para respirar, si tiene historia de reacciones severas a las picaduras de vida marina o si la picadura fue en cara o cuello."],
                    ["Una persona que ha sido mordida sentirá dolor. Busque las marcas de los colmillos y la hinchazón.","Llame a la cruz roja si una persona es mordida por una serpiente venenosa.","Lave suavemente la herida","Mantenga la parte mordida a un nivel más bajo que el corazón. Mantenga a la persona calmada y no permita que camine a menos que sea absolutamente necesario, cualquier estado alterado hará que el corazón lata más rápido y el veneno puede afectar de forma más rápida."],["No trate de detener, capturar o retener al animal que mordió a la persona.","Llame a la cruz roja si la herida de la mordedura de un animal está sangrando profusamente o si el animal pudiera tener rabia.","Si el sangrado es grave controle el sangrado primero, no intente limpiar la herida. La herida se podrá limpiar en un centro médico, lo más importante es evitar que l persona sangre.","Si el sangrado es leve, lave la herida con agua y jabón neutro. Después de controlar el sangrado, si cuenta con ungüento antibiótico apliquelo y cubra con un vendaje. ","No utilice agua oxigenada para limpiar la herida, esto solo quemará más el tejido."]]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checarNum()
        self.navigationItem.setHidesBackButton(true, animated:true);
    }
    
    //func webViewDidFinishLoad(webView: UIWebView) {
    //  self.espera.hidden = true
    //}
    
    private func checarNum(){
        if emergencia == "Alergias/Anafilaxia"{
            numEmergencia = 0}
        else if emergencia == "Ataque de ansiedad"{
            numEmergencia = 1}
        else if emergencia == "Atragantamiento/Asfixia"{
            numEmergencia = 2}
        else if emergencia == "Convulsiones/Epilepsia"{
            numEmergencia = 3}
        else if emergencia == "Crisis asmática"{
            numEmergencia = 4}
        else if emergencia == "Embolia cerebral"{
            numEmergencia = 5}
        else if emergencia == "Emergencias diabéticas"{
            numEmergencia = 6}
        else if emergencia == "Envenenamiento/sustancias peligrosas" {
            numEmergencia = 7}
        else if emergencia == "Estado de choque" {
            numEmergencia = 8}
        else if emergencia == "Fracturas" {
            numEmergencia = 9}
        else if emergencia == "Golpe de calor" {
            numEmergencia = 10}
        else if emergencia == "Hipotermia" {
            numEmergencia = 11}
        else if emergencia == "Inconsciente y respira" {
            numEmergencia = 12}
        else if emergencia == "Inconsciente y no respira" {
            numEmergencia = 13}
        else if emergencia == "Infarto al corazón" {
            numEmergencia = 14}
        else if emergencia == "Lesiones en la cabeza" {
            numEmergencia = 15}
        else if emergencia == "Meningitis" {
            numEmergencia = 16}
        else if emergencia == "Quemaduras" {
            numEmergencia = 17}
        else if emergencia == "Sangrado" {
            numEmergencia = 18}
        else if emergencia == "Torceduras y esguinces" {
            numEmergencia = 19}
        else if emergencia == "Picaduras y mordeduras de insectos" {
            numEmergencia = 20}
        else if emergencia == "Garrapatas" {
            numEmergencia = 21}
        else if emergencia == "Picadura/ mordedura de alacranes o arañas" {
            numEmergencia = 22}
        else if emergencia == "Picadura de medusa" {
            numEmergencia = 23}
        else if emergencia == "Mordedura de serpiente venenosa" {
            numEmergencia = 24}
        else if emergencia == "Mordeduras de animales" {
            numEmergencia = 25}
        else{
            print("emergecia diferente")
            numEmergencia = -1
            //self.navigationController?.popToViewController(FirstViewController, animated: true)
            dismissViewControllerAnimated(true, completion: nil)
        }
       

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView:	UITableView)	->	Int {
        return	1
    }
    func tableView(tableView:	UITableView,	numberOfRowsInSection section:	Int)	->	Int {
        if(numEmergencia != -1){
            return self.arrPasos[numEmergencia].count}
        else{
            return 0
        }
    }
    func tableView(tableView:	UITableView,	cellForRowAtIndexPath indexPath:	NSIndexPath)	->	UITableViewCell {
        let celda = tableView.dequeueReusableCellWithIdentifier("celdaID", forIndexPath: indexPath)
        celda.textLabel!.text =	self.arrPasos[numEmergencia][indexPath.row]
        celda.textLabel?.numberOfLines = 0
        celda.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        celda.textLabel?.font = UIFont.systemFontOfSize(11.0)
        celda.imageView?.image = UIImage(named: "\((indexPath.row )+1).jpg")
        
        
        return celda
    }
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = .clearColor()
        cell.textLabel?.textColor = UIColor.grayColor()
      
        
    }
    

    @IBAction func back(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
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
