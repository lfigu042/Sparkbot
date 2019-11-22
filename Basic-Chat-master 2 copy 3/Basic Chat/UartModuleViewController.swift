//
//  UartModuleViewController.swift
//  Basic Chat
//
//  Created by Trevor Beaton on 12/4/16.
//  Copyright © 2016 Vanguard Logic LLC. All rights reserved.
//
import UIKit
import CoreBluetooth

class UartModuleViewController: UIViewController, CBPeripheralManagerDelegate, UITextViewDelegate, UITextFieldDelegate {
    
    //UI
    @IBOutlet weak var baseTextView: UITextView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var switchUI: UISwitch!
    
//reference variables for buttons individually
    @IBOutlet weak var yellowBtn: UIButton!
    @IBOutlet weak var greenBtn: UIButton!
    @IBOutlet weak var redBtn: UIButton!
    @IBOutlet weak var blueBtn: UIButton!
    
    @IBOutlet weak var pilotBtn: UIButton!
    @IBOutlet weak var alexaBtn: UIButton!
    
    
    @IBOutlet weak var clawUpBtn: UIButton!
    @IBOutlet weak var clawDownBtn: UIButton!
    //Data
    var peripheralManager: CBPeripheralManager?
    var peripheral: CBPeripheral!
    private var consoleAsciiText:NSAttributedString? = NSAttributedString(string: "")
    
// Send specific letters while btn is held down
//    Yellow=Up Green=Left Red=right blue=down
    
    @IBAction func yellowOnDown(_ sender: UIButton) {
        writeValue(data: "a")
    }
    @IBAction func greenOnDown(_ sender: UIButton) {
        writeValue(data: "d")
    }
    @IBAction func redOnDown(_ sender: UIButton) {
        writeValue(data: "b")
    }
    @IBAction func blueOnDown(_ sender: UIButton) {
        writeValue(data: "c")
    }
    
    @IBAction func clawUpOnDown(_ sender: UIButton) {
        clawUpBtn.backgroundColor = UIColor.yellow
        writeValue(data: "h")
    }
    @IBAction func clawDownOnDown(_ sender: UIButton) {
        clawDownBtn.backgroundColor = UIColor.yellow
        writeValue(data: "i")
    }
    
 // Send "e" when btn is unclicked
        @IBAction func yellowRelease(_ sender: UIButton) {
            writeValue(data: "e")
        }
        @IBAction func greenRelease(_ sender: UIButton) {
            writeValue(data: "e")
        }
        @IBAction func redRelease(_ sender: UIButton) {
            writeValue(data: "e")
        }
        @IBAction func blueRelease(_ sender: UIButton) {
            writeValue(data: "e")
        }
        @IBAction func clawUpRelease(_ sender: UIButton){
            clawUpBtn.backgroundColor = UIColor.white
        }
        @IBAction func clawDownRelease(_ sender: UIButton){
            clawDownBtn.backgroundColor = UIColor.white
        }
    
//Auto-Pilot btn send "f" when clicked once, as well as disable the previous btns and shade them grey. Pressing it once more will send a "g" and enable the btns again
    
    
    @IBAction func TogglePilot(_ sender: UIButton) {
        if sender.titleLabel!.text == "Auto-Pilot OFF"{
            sender.setTitle("Auto-Pilot ON", for: UIControl.State.normal)
                writeValue(data: "f")
            yellowBtn.isEnabled = false
            greenBtn.isEnabled = false
            redBtn.isEnabled = false
            blueBtn.isEnabled = false
            clawUpBtn.isEnabled = false
            clawDownBtn.isEnabled = false
            alexaBtn.isEnabled = false
            
            clawDownBtn.backgroundColor = UIColor.gray
            clawUpBtn.backgroundColor = UIColor.gray
            yellowBtn.backgroundColor = UIColor.gray
            greenBtn.backgroundColor = UIColor.gray
            redBtn.backgroundColor = UIColor.gray
            blueBtn.backgroundColor = UIColor.gray
            alexaBtn.backgroundColor = UIColor.gray
            pilotBtn.backgroundColor = UIColor.init(displayP3Red: 41.0/255, green: 130.0/255, blue: 255.0/255, alpha: 1.0)
            
        }else{
            sender.setTitle("Auto-Pilot OFF", for: UIControl.State.normal)
                writeValue(data: "g")
            
              yellowBtn.isEnabled = true
              greenBtn.isEnabled = true
              redBtn.isEnabled = true
              blueBtn.isEnabled = true
              clawUpBtn.isEnabled = true
              clawDownBtn.isEnabled = true
              alexaBtn.isEnabled = true
            
              clawDownBtn.backgroundColor = UIColor.white
              clawUpBtn.backgroundColor = UIColor.white
            yellowBtn.backgroundColor = UIColor.init(displayP3Red: 41.0/255, green: 130.0/255, blue: 255.0/255, alpha: 1.0)
              greenBtn.backgroundColor = UIColor.init(displayP3Red: 41.0/255, green: 130.0/255, blue: 255.0/255, alpha: 1.0)
              redBtn.backgroundColor = UIColor.init(displayP3Red: 41.0/255, green: 130.0/255, blue: 255.0/255, alpha: 1.0)
              blueBtn.backgroundColor = UIColor.init(displayP3Red: 41.0/255, green: 130.0/255, blue: 255.0/255, alpha: 1.0)
              pilotBtn.backgroundColor = UIColor.gray
              alexaBtn.backgroundColor = UIColor.gray
        }
    }
    //end of autopilot
    //start of alexa
//       @IBAction func TogglePilot(_ sender: UIButton) {}
    
    @IBAction func ToggleAlexa(_ sender: UIButton) {
        if sender.titleLabel!.text == "Alexa OFF"{
            sender.setTitle("Alexa ON", for: UIControl.State.normal)
                writeValue(data: "j")
            yellowBtn.isEnabled = false
            greenBtn.isEnabled = false
            redBtn.isEnabled = false
            blueBtn.isEnabled = false
            clawUpBtn.isEnabled = false
            clawDownBtn.isEnabled = false
            pilotBtn.isEnabled = false
            
            clawDownBtn.backgroundColor = UIColor.gray
            clawUpBtn.backgroundColor = UIColor.gray
            yellowBtn.backgroundColor = UIColor.gray
            greenBtn.backgroundColor = UIColor.gray
            redBtn.backgroundColor = UIColor.gray
            blueBtn.backgroundColor = UIColor.gray
            alexaBtn.backgroundColor = UIColor.init(displayP3Red: 41.0/255, green: 130.0/255, blue: 255.0/255, alpha: 1.0)
            pilotBtn.backgroundColor = UIColor.gray
            
        }else{
            sender.setTitle("Alexa OFF", for: UIControl.State.normal)
                writeValue(data: "k")
            
              yellowBtn.isEnabled = true
              greenBtn.isEnabled = true
              redBtn.isEnabled = true
              blueBtn.isEnabled = true
              clawUpBtn.isEnabled = true
              clawDownBtn.isEnabled = true
              pilotBtn.isEnabled = true
            
              clawDownBtn.backgroundColor = UIColor.white
              clawUpBtn.backgroundColor = UIColor.white
            yellowBtn.backgroundColor = UIColor.init(displayP3Red: 41.0/255, green: 130.0/255, blue: 255.0/255, alpha: 1.0)
              greenBtn.backgroundColor = UIColor.init(displayP3Red: 41.0/255, green: 130.0/255, blue: 255.0/255, alpha: 1.0)
              redBtn.backgroundColor = UIColor.init(displayP3Red: 41.0/255, green: 130.0/255, blue: 255.0/255, alpha: 1.0)
              blueBtn.backgroundColor = UIColor.init(displayP3Red: 41.0/255, green: 130.0/255, blue: 255.0/255, alpha: 1.0)
              pilotBtn.backgroundColor = UIColor.gray
              alexaBtn.backgroundColor = UIColor.gray
        }
    }
    //end of alexa
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"Back", style:.plain, target:nil, action:nil)
//        self.baseTextView.delegate = self
//        self.inputTextField.delegate = self
        //Base text view setup
//        self.baseTextView.layer.borderWidth = 3.0
//        self.baseTextView.layer.borderColor = UIColor.blue.cgColor
//        self.baseTextView.layer.cornerRadius = 3.0
//        self.baseTextView.text = ""
        //Input Text Field setup
//        self.inputTextField.layer.borderWidth = 2.0
//        self.inputTextField.layer.borderColor = UIColor.blue.cgColor
//        self.inputTextField.layer.cornerRadius = 3.0
        //Create and start the peripheral manager
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        //-Notification for updating the text view with incoming text
        updateIncomingData()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        self.baseTextView.text = ""
//
//
//    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // peripheralManager?.stopAdvertising()
        // self.peripheralManager = nil
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        
    }
    
    func updateIncomingData () {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "Notify"), object: nil , queue: nil){
            notification in
            let appendString = "\n"
            let myFont = UIFont(name: "Helvetica Neue", size: 15.0)
            let myAttributes2 = [convertFromNSAttributedStringKey(NSAttributedString.Key.font): myFont!, convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor): UIColor.red]
            let attribString = NSAttributedString(string: "[Incoming]: " + (characteristicASCIIValue as String) + appendString, attributes: convertToOptionalNSAttributedStringKeyDictionary(myAttributes2))
            let newAsciiText = NSMutableAttributedString(attributedString: self.consoleAsciiText!)
//            self.baseTextView.attributedText = NSAttributedString(string: characteristicASCIIValue as String , attributes: convertToOptionalNSAttributedStringKeyDictionary(myAttributes2))
            
            newAsciiText.append(attribString)
            
            self.consoleAsciiText = newAsciiText
//            self.baseTextView.attributedText = self.consoleAsciiText
            
        }
    }
    
//    @IBAction func clickSendAction(_ sender: AnyObject) {
//        outgoingData()
//
//    }
    
    
    
    func outgoingData () {
//        let appendString = "\n"
        
//        let inputText = inputTextField.text
        
//        let myFont = UIFont(name: "Helvetica Neue", size: 15.0)
//        let myAttributes1 = [convertFromNSAttributedStringKey(NSAttributedString.Key.font): myFont!, convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor): UIColor.blue]
        
//        writeValue(data: inputText!)
        
//        let attribString = NSAttributedString(string: "[Outgoing]: " + inputText! + appendString, attributes: convertToOptionalNSAttributedStringKeyDictionary(myAttributes1))
//        let newAsciiText = NSMutableAttributedString(attributedString: self.consoleAsciiText!)
//        newAsciiText.append(attribString)
        
//        consoleAsciiText = newAsciiText
//        baseTextView.attributedText = consoleAsciiText
        //erase what's in the text field
//        inputTextField.text = ""
        
    }
    
    // Write functions
    func writeValue(data: String){
        let valueString = (data as NSString).data(using: String.Encoding.utf8.rawValue)
        //change the "data" to valueString
        if let blePeripheral = blePeripheral{
            if let txCharacteristic = txCharacteristic {
                blePeripheral.writeValue(valueString!, for: txCharacteristic, type: CBCharacteristicWriteType.withResponse)
            }
        }
    }
    
    func writeCharacteristic(val: Int8){
        var val = val
        let ns = NSData(bytes: &val, length: MemoryLayout<Int8>.size)
        blePeripheral!.writeValue(ns as Data, for: txCharacteristic!, type: CBCharacteristicWriteType.withResponse)
    }
    
    
    
    //MARK: UITextViewDelegate methods
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView === baseTextView {
            //tapping on consoleview dismisses keyboard
            inputTextField.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x:0, y:250), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x:0, y:0), animated: true)
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            return
        }
        print("Peripheral manager is running")
    }
    
    //Check when someone subscribe to our characteristic, start sending the data
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
        print("Device subscribe to characteristic")
    }
    
    //This on/off switch sends a value of 1 and 0 to the Arduino
    //This can be used as a switch or any thing you'd like
    @IBAction func switchAction(_ sender: Any) {
        if switchUI.isOn {
            print("On ")
            writeCharacteristic(val: 1)
        }
        else
        {
            print("Off")
            writeCharacteristic(val: 0)
            print(writeCharacteristic)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        outgoingData()
        return(true)
    }
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        if let error = error {
            print("\(error)")
            return
        }
    }
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
