//
//  ViewController.swift
//  Tipping Kitty
//
//  Created by Nguyen T Do on 27/02/2016.
//  Copyright © 2016 Nguyen Do. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Labels
    
    @IBOutlet weak var billDisplay: UILabel!
    
    @IBOutlet weak var tipPercentageDisplay: UILabel!
    
    @IBOutlet weak var tipDisplay: UILabel!
    
    @IBOutlet weak var totalDisplay: UILabel!
    
    @IBOutlet weak var splitIntoNumberOfPeopleDisplay: UILabel!
    
    @IBOutlet weak var splitDisplay: UILabel!
    
    
    
    
    
    var decimalIsUsed = false
    var tipAmount = 0.1       // Default tip amount
    var splitIntoANumberOfPeople = 1.0       // Default split, yes for the sake of Swift
    
    @IBAction func appenDigitFromKeypad(sender: UIButton) {
        let digit = sender.currentTitle!
        if digit != "0" {
            if billDisplay.text != "0" {
                billDisplay.text = billDisplay.text! + digit
                updateTipTotalSplit()
            } else {
                billDisplay.text = digit
                updateTipTotalSplit()
            }
        } else {
            if billDisplay.text != "0" {
                billDisplay.text = billDisplay.text! + digit
                updateTipTotalSplit()
            }
            // Do not update if zero is pressed first of all
        }
    }
    
    @IBAction func decimalKeyTouch(sender: UIButton) {
        let decimalKey = sender.currentTitle!
        if decimalKey == "." {
            if !decimalIsUsed {
                billDisplay.text = billDisplay.text! + decimalKey
                decimalIsUsed = true
            }
        }
    }
    
    @IBAction func clearUpView(sender: UIButton) {
        if billDisplayValue == 0 {      // Press C twice to set Tip and Split to default
            tipAmount = 0.1
            tipPercentageDisplay.text = String(format: "%.0f", tipAmount * 100) + "%"
            splitIntoANumberOfPeople = 1.0
            splitIntoNumberOfPeopleDisplay.text = String(format: "%.0f", splitIntoANumberOfPeople) + "👤"
        }
        billDisplay.text! = "0"
        decimalIsUsed = false
        tipDisplay.text! = "0"
        totalDisplay.text! = "0"
        splitDisplay.text! = "0"
        backupDataUponExit()
    }
    
    @IBAction func adjustTip(sender: UIButton) {
        let operation = sender.currentTitle!
        switch operation {
        case "-": if tipAmount >= 0.05 {
            tipAmount -= 0.05
            }
        case "+": if tipAmount <= 0.8 {
            tipAmount += 0.05
            }
        default: break
        }
        tipPercentageDisplay.text = String(format: "%.0f", tipAmount * 100) + "%"
        updateTipTotalSplit()
        print("Tip Amount = \(tipAmount)")
    }
    
    @IBAction func adjustSplit(sender: UIButton) {
        let operation = sender.currentTitle!
        switch operation {
        case "-": if splitIntoANumberOfPeople >= 2 {
            splitIntoANumberOfPeople -= 1
            }
        case "+": if splitIntoANumberOfPeople <= 29 {
            splitIntoANumberOfPeople += 1
            }
        default: break
        }
        // print("Number of people to split = \(splitIntoANumberOfPeople)")
        splitIntoNumberOfPeopleDisplay.text = String(format: "%.0f", splitIntoANumberOfPeople) + "👤"
        updateTipTotalSplit()
    }
    
    func updateTipTotalSplit() {
        // Let calculate the Tip
        // print("Tip Amount = \(billDisplayValue * tipAmount)")
        tipDisplay.text = String(format: "%.2f", billDisplayValue * tipAmount)
        
        // Let calculate the Total
        let totalAmount = billDisplayValue + billDisplayValue * tipAmount
        totalDisplay.text = String(format: "%.2f", totalAmount)
        
        // Let calculate the Split
        splitDisplay.text = String(format: "%.2f", totalAmount / splitIntoANumberOfPeople)
        backupDataUponExit()
    }
    
    func backupDataUponExit () {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(Int(tipAmount * 100), forKey: "current tip")
        defaults.setObject(billDisplay.text, forKey: "bill")
        defaults.setDouble(splitIntoANumberOfPeople, forKey: "split")
        defaults.synchronize()
    }
    
    var billDisplayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(billDisplay.text!)!.doubleValue
        }
        set {
                billDisplay.text = "\(newValue)"
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        let defaults = NSUserDefaults.standardUserDefaults()
        tipAmount = defaults.doubleForKey("current tip") / 100    // Yes there will be a lovely conversion
        // print("tipAmount from default tip = \(tipAmount)")
        if (defaults.stringForKey("current tip") == nil) { tipAmount = 0.1 }  // Make sure this is verified!
        if (defaults.objectForKey("bill") != nil) { billDisplay.text = defaults.objectForKey("bill") as? String }
        else { billDisplay.text = "0" }
        if (defaults.doubleForKey("split") != 0) { splitIntoANumberOfPeople = defaults.doubleForKey("split") }
        else { splitIntoANumberOfPeople = 0 }
        splitIntoNumberOfPeopleDisplay.text = String(format: "%.0f", splitIntoANumberOfPeople) + "👤"  // This should be better handled!
        if billDisplayValue != 0 { updateTipTotalSplit() }
        tipPercentageDisplay.text = String(format: "%.0f", tipAmount * 100) + "%"
        // print("Tip amount at first = \(tipAmount)")
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
        backupDataUponExit()
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

