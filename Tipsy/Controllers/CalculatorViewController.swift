//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    var tipBtnArray: [UIButton] = []
    var numberOfSplit: Double = 0.0
    var localTip: Double = 0.0
    var total: String = "0.0"
    var tipStr = "10%"
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        sender.isSelected = true
        tipStr = sender.titleLabel!.text ?? "10%"
        localTip = (Double(tipStr.dropLast()) ?? 10) / 100
        for button in tipBtnArray {
            if(button != sender){
                button.isSelected = false
            }
        }
    }
    @IBAction func setpperValueChanged(_ sender: UIStepper) {
        //print(Int(sender.value.description)!)
        billTextField.endEditing(true)
        numberOfSplit = Double(Int(sender.value))
        splitNumberLabel.text = String(Int(sender.value))
    }
    @IBAction func calculatePressed(_ sender: UIButton) {
        let result = Double(billTextField.text!)!*(1 + localTip) / numberOfSplit
        total = String(format: "%.2f", result)
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destination = segue.destination as! ResultsViewController
            destination.totalValue = total
            destination.numberOfPerson = splitNumberLabel.text!
            destination.tip = tipStr
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tipBtnArray.append(zeroPctButton)
        tipBtnArray.append(tenPctButton)
        tipBtnArray.append(twentyPctButton)
        stepper.wraps = true
        stepper.autorepeat = true
    }
    

}

