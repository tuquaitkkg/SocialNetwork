//
//  PasscodeViewController.swift
//  SocialAnalysis
//
//  Created by Duc.LT on 5/31/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class PasscodeViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var lblTitle: UILabel!
    let touchMe = BiometricIDAuth()
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet var PasscodeTf: [UITextField]!
    @IBOutlet var NumberButtons: [UIButton]!
    var strPasscode : String! = ""
    var strConfirmPasscode : String! = ""
    var checkPasscode : Bool! = false
    var typeView : NSInteger = 0
    
    @IBOutlet weak var btnTouchID: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for button in NumberButtons {
            button.layer.cornerRadius = button.frame.size.width/2;
            button.layer.masksToBounds = true
            button.isExclusiveTouch = true
        }
        for textfield in PasscodeTf {
            textfield.isUserInteractionEnabled = false
            textfield.text = ""
        }
        btnTouchID.isHidden = typeView == 1 ? true : false
        btnCancel.isHidden = typeView == 1 ? false : true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickTouchId(_ sender: Any) {
        touchMe.authenticateUser() { [weak self] message in
            if let message = message {
                // if the completion is not nil show an alert
//                let alertView = UIAlertController(title: "Error",
//                                                  message: message,
//                                                  preferredStyle: .alert)
//                let okAction = UIAlertAction(title: "Darn!", style: .default)
//                alertView.addAction(okAction)
//                self?.present(alertView, animated: true)
                
            } else {
                if self?.typeView == 0 {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.setupMainView()
                } else {
                    self?.dismiss(animated: true, completion: nil)
                }
                
            }
        }
    }
    
    @IBAction func clickBack(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: "isPasscode") == false {
            if strPasscode.count == 6 {
                strConfirmPasscode = String(strConfirmPasscode.dropLast())
            } else {
                strPasscode = String(strPasscode.dropLast())
            }
            
            setTextfield()
        } else {
            strPasscode = String(strPasscode.dropLast())
            setTextfieldWhenTurnOffPasscode()
        }
        
    }
    
    @IBAction func clickNumber(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: "isPasscode") == false {
            if strConfirmPasscode.count > 5 {
                return
            }
            let button = sender as! UIButton
            if strPasscode.count == 6 {
                strConfirmPasscode = strConfirmPasscode + String(button.tag)
            } else {
                strPasscode = strPasscode + String(button.tag)
            }
            setTextfield()
        } else {
            if strPasscode.count > 5 {
                return
            }
            let button = sender as! UIButton
            strPasscode = strPasscode + String(button.tag)
            setTextfieldWhenTurnOffPasscode()
        }
        
    }
    
    func setTextfield() {
        UIView.animate(withDuration: 0, animations: {
            if self.checkPasscode == false {
                for textfield in self.PasscodeTf {
                    if self.strPasscode.count > textfield.tag - 1 {
                        textfield.text = "0"
                    } else {
                        textfield.text = ""
                    }
                }
            }
        }) { (isComplete) in
            if isComplete == true {
                if self.strPasscode.count == 6 {
                    if self.checkPasscode == false {
                        sleep(1)
                    }
                    
                    self.checkPasscode = true
                    self.lblTitle.text = "Confirm Passcode"
                    
                    UIView.animate(withDuration: 0, animations: {
                        for textfield in self.PasscodeTf {
                            if self.strConfirmPasscode.count > textfield.tag - 1 {
                                textfield.text = "0"
                            } else {
                                textfield.text = ""
                            }
                            
                        }
                    }, completion: { (isComplete) in
                        if self.strConfirmPasscode.count == 6 {
                            sleep(1)
                            if self.strPasscode != self.strConfirmPasscode {
                                self.strConfirmPasscode = ""
                                for textfield in self.PasscodeTf {
                                    textfield.text = ""
                                }
                            } else {
                                UserDefaults.standard.set(true, forKey: "isPasscode")
                                UserDefaults.standard.set(self.strPasscode, forKey: "strPasscode")
                                UserDefaults.standard.synchronize()
                                self.dismiss(animated: true, completion: nil)
                            }
                            
                        }
                    })
                    
                }
            }
            
        }
    }
    
    func setTextfieldWhenTurnOffPasscode() {
        UIView.animate(withDuration: 0, animations: {
            if self.checkPasscode == false {
                for textfield in self.PasscodeTf {
                    if self.strPasscode.count > textfield.tag - 1 {
                        textfield.text = "0"
                    } else {
                        textfield.text = ""
                    }
                }
            }
        }) { (isComplete) in
            if isComplete == true {
                if self.strPasscode.count == 6 {
                    sleep(1)
                    let oldPasscode : String = UserDefaults.standard.object(forKey: "strPasscode") as! String
                    
                    if self.strPasscode != oldPasscode {
                        self.strPasscode = ""
                        for textfield in self.PasscodeTf {
                            textfield.text = ""
                        }
                    } else {
                        if self.typeView == 0 {
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            appDelegate.setupMainView()
                        } else {
                            UserDefaults.standard.set(false, forKey: "isPasscode")
                            UserDefaults.standard.set(nil, forKey: "strPasscode")
                            UserDefaults.standard.synchronize()
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                    
                }
            }
            
        }
    }
}
