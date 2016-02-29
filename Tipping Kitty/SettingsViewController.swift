//
//  SettingsViewController.swift
//  Tipping Kitty
//
//  Created by Nguyen T Do on 28/02/2016.
//  Copyright © 2016 Nguyen Do. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTipDisplay: UILabel!
    
    @IBOutlet weak var newDefaultTip: UISlider!
    
    
    @IBAction func adjustNewDefaultTip(sender: UISlider) {
        defaultTipDisplay.text = String(format: "%.0i", Int(sender.value)) + "%"
        updateDefaultTip()
    }

    func updateDefaultTip () {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(Int(newDefaultTip.value), forKey: "current tip")
        defaults.synchronize()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("settings view will disappear")
        updateDefaultTip()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("settings view will appear")
        let defaults = NSUserDefaults.standardUserDefaults()
        newDefaultTip.value = defaults.floatForKey("current tip")
        defaultTipDisplay.text = String(format: "%.0i", Int(newDefaultTip.value)) + "%"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
