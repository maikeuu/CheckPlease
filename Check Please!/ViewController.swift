//
//  ViewController.swift
//  Check Please!
//
//  Created by Mike Lin on 12/26/17.
//  Copyright © 2017 Mike Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var twoWayBillLabel: UILabel!
    @IBOutlet weak var threeWayBillLabel: UILabel!
    @IBOutlet weak var fourWayBillLabel: UILabel!
    
    
    var userIsTyping = false
    var billStored = false
    let tipPercentages = [0.15, 0.18, 0.2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.billField.becomeFirstResponder()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if billStored {
            let defaults = UserDefaults.standard
            let bill = defaults.double(forKey: "bill")
            billField.text = String(format: "%.2f", bill)
        }
        print("view will appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let bill = Double(billField.text!) ?? 0
        let defaults = UserDefaults.standard
        defaults.set(bill, forKey: "bill")
        defaults.synchronize()
        billStored = true
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }

    
//    @IBAction func userHasBegunTyping(_ sender: UITextField) {
//        if !userIsTyping {
//            billField.text = ""
//            userIsTyping = true
//        }
//    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        twoWayBillLabel.text = String(format: "$%.2f", total/2)
        threeWayBillLabel.text = String(format: "$%.2f", total/3)
        fourWayBillLabel.text = String(format: "$%.2f", total/4)
    }
}

