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
    var strOldPasscode : String! = ""
    var strPasscode : String! = ""
    var strConfirmPasscode : String! = ""
    var checkPasscode : Bool! = false
    var typeView : NSInteger = 0
    
    @IBOutlet weak var btnTouchID: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        for button in NumberButtons {
            button.layer.cornerRadius = button.frame.size.width/2;
            button.layer.masksToBounds = true
            button.isExclusiveTouch = true
            button.backgroundColor = UIColor.white
            button.setTitleColor(UIColor.init(red: 94/255, green: 229/255, blue: 163/255, alpha: 1), for: UIControlState.normal)
            button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 40)
        }
        for textfield in PasscodeTf {
            textfield.isUserInteractionEnabled = false
            textfield.text = ""
            textfield.layer.borderColor = UIColor.white.cgColor
            textfield.layer.borderWidth = 1
            textfield.layer.masksToBounds = true
            textfield.layer.cornerRadius = textfield.frame.size.width/2
            textfield.backgroundColor = UIColor.clear
        }
        if UserDefaults.standard.bool(forKey: "isPasscode") == false {
            btnTouchID.isHidden = true
        } else {
            btnTouchID.isHidden = typeView == 1 ? true : false
        }
        btnCancel.isHidden = typeView == 1 ? false : true
        if typeView == 1 {
            self.lblTitle.text = "Enter your old Passcode"
        }
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
                let alertView = UIAlertController(title: "Error",
                                                  message: message,
                                                  preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK!", style: .default)
                alertView.addAction(okAction)
                self?.present(alertView, animated: true)
                
            } else {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.setupMainView()
                
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
            if typeView == 0 {
                strPasscode = String(strPasscode.dropLast())
                setTextfieldWhenTurnOffPasscode()
            } else {
                if strOldPasscode.count < 6 {
                    strOldPasscode = String(strOldPasscode.dropLast())
                } else if strOldPasscode.count == 6 && strPasscode.count < 6 {
                    strPasscode = String(strPasscode.dropLast())
                } else {
                    strConfirmPasscode = String(strConfirmPasscode.dropLast())
                }
                setTextfieldWhenChangePasscode()
            }
        }
    }
    
    @IBAction func clickNumber(_ sender: Any) {
        let button = sender as! UIButton
        if UserDefaults.standard.bool(forKey: "isPasscode") == false {
            if strConfirmPasscode.count > 5 {
                return
            }
            if strPasscode.count == 6 {
                strConfirmPasscode = strConfirmPasscode + String(button.tag)
            } else {
                strPasscode = strPasscode + String(button.tag)
            }
            setTextfield()
        } else {
            if typeView == 1 {
                if strOldPasscode.count < 6 {
                    if strOldPasscode.count > 5 {
                        return
                    }
                    strOldPasscode = strOldPasscode + String(button.tag)
                } else if strOldPasscode.count == 6 && strPasscode.count < 6 {
                    if strPasscode.count > 5 {
                        return
                    }
                    strPasscode = strPasscode + String(button.tag)
                } else {
                    if strConfirmPasscode.count > 5 {
                        return
                    }
                    strConfirmPasscode = strConfirmPasscode + String(button.tag)
                }
                setTextfieldWhenChangePasscode()
                
            } else {
                if strPasscode.count > 5 {
                    return
                }
                strPasscode = strPasscode + String(button.tag)
                setTextfieldWhenTurnOffPasscode()
            }
        }
        
    }
    
    func setTextfield() {
        UIView.animate(withDuration: 0, animations: {
            if self.checkPasscode == false {
                for textfield in self.PasscodeTf {
                    if self.strPasscode.count > textfield.tag - 1 {
                        textfield.backgroundColor = UIColor.white
                    } else {
                        textfield.backgroundColor = UIColor.clear
                    }
                }
            }
        }) { (isComplete) in
            if isComplete == true {
                if self.strPasscode.count == 6 {
//                    if self.checkPasscode == false {
//                        sleep(1)
//                    }
                    
                    self.checkPasscode = true
                    self.lblTitle.text = "Confirm Passcode"
                    
                    UIView.animate(withDuration: 0, animations: {
                        for textfield in self.PasscodeTf {
                            if self.strConfirmPasscode.count > textfield.tag - 1 {
                                textfield.backgroundColor = UIColor.white
                            } else {
                                textfield.backgroundColor = UIColor.clear
                            }
                            
                        }
                    }, completion: { (isComplete) in
                        if self.strConfirmPasscode.count == 6 {
//                            sleep(1)
                            if self.strPasscode != self.strConfirmPasscode {
                                self.strConfirmPasscode = ""
                                for textfield in self.PasscodeTf {
                                   textfield.backgroundColor = UIColor.clear
                                }
                            } else {
                                UserDefaults.standard.set(true, forKey: "isPasscode")
                                UserDefaults.standard.set(self.strPasscode, forKey: "strPasscode")
                                UserDefaults.standard.synchronize()
                                if self.typeView == 0 {
                                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                    appDelegate.setupMainView()
                                } else {
                                    self.dismiss(animated: true, completion: nil)
                                }
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
                        textfield.backgroundColor = UIColor.white
                    } else {
                        textfield.backgroundColor = UIColor.clear
                    }
                }
            }
        }) { (isComplete) in
            if isComplete == true {
                if self.strPasscode.count == 6 {
//                    sleep(1)
                    if (UserDefaults.standard.object(forKey: "strPasscode") == nil) {
                        return
                    }
                    let oldPasscode : String = UserDefaults.standard.object(forKey: "strPasscode") as! String
                    
                    if self.strPasscode != oldPasscode {
                        self.strPasscode = ""
                        for textfield in self.PasscodeTf {
                            textfield.backgroundColor = UIColor.clear
                        }
                    } else {
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.setupMainView()
                        
                    }
                    
                }
            }
            
        }
    }
    
    func setTextfieldWhenChangePasscode() {
        UIView.animate(withDuration: 0, animations: {
            if self.strOldPasscode.count < 6 {
                for textfield in self.PasscodeTf {
                    if self.strOldPasscode.count > textfield.tag - 1 {
                        textfield.backgroundColor = UIColor.white
                    } else {
                        textfield.backgroundColor = UIColor.clear
                    }
                }
            }
        }) { (isComplete) in
            if isComplete == true {
                if self.strOldPasscode.count == 6 {
//                    sleep(1)
                    if (UserDefaults.standard.object(forKey: "strPasscode") == nil) {
                        return
                    }
                    let oldPasscode : String = UserDefaults.standard.object(forKey: "strPasscode") as! String
                    
                    if self.strOldPasscode != oldPasscode {
                        self.strOldPasscode = ""
                        for textfield in self.PasscodeTf {
                            textfield.backgroundColor = UIColor.clear
                        }
                    } else {
                        if self.strPasscode.count < 6 {
                             self.lblTitle.text = "Enter new passcode"
                        }
                        self.setTextfield()
                    }
                    
                }
            }
            
        }
    }
    
}
