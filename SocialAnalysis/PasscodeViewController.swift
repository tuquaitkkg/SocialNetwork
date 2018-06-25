//
//  PasscodeViewController.swift
//  SocialAnalysis
//
//  Created by Duc.LT on 5/31/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import BiometricAuthentication

class PasscodeViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var lblTitle: UILabel!
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
        btnTouchID.isHidden = typeView == 1 ? true : false
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
        
        // start authentication
        BioMetricAuthenticator.authenticateWithBioMetrics(reason: "", success: {
            
            // authentication successful
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.setupMainView()
            
        }, failure: { [weak self] (error) in
            
            
            // do nothing on canceled
            if error == .canceledByUser || error == .canceledBySystem {
                return
            }
                
                // device does not support biometric (face id or touch id) authentication
            else if error == .biometryNotAvailable {
                self?.showErrorAlert(message: error.message())
            }
                
                // show alternatives on fallback button clicked
            else if error == .fallback {
                
                // here we're entering username and password
            }
                
                // No biometry enrolled in this device, ask user to register fingerprint or face
            else if error == .biometryNotEnrolled {
                self?.showGotoSettingsAlert(message: error.message())
            }
                
                // Biometry is locked out now, because there were too many failed attempts.
                // Need to enter device passcode to unlock.
            else if error == .biometryLockedout {
                self?.showPasscodeAuthentication(message: error.message())
            }
                
                // show error on authentication failed
            else {
                self?.showErrorAlert(message: error.message())
            }
        })
    }
    
    // show passcode authentication
    func showPasscodeAuthentication(message: String) {
        
        BioMetricAuthenticator.authenticateWithPasscode(reason: message, success: {
            // passcode authentication success
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.setupMainView()
            
        }) { (error) in
            print(error.message())
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

extension PasscodeViewController {
    
    func showAlert(title: String, message: String) {
        
        let okAction = AlertAction(title: OKTitle)
        let alertController = getAlertViewController(type: .alert, with: title, message: message, actions: [okAction], showCancel: false) { (button) in
        }
        present(alertController, animated: true, completion: nil)
    }
    
    func showLoginSucessAlert() {
        showAlert(title: "Success", message: "Login successful")
    }
    
    func showErrorAlert(message: String) {
        showAlert(title: "Error", message: message)
    }
    
    func showGotoSettingsAlert(message: String) {
        let settingsAction = AlertAction(title: "Go to settings")
        
        let alertController = getAlertViewController(type: .alert, with: "Error", message: message, actions: [settingsAction], showCancel: true, actionHandler: { (buttonText) in
            if buttonText == CancelTitle { return }
            
            // open settings
            let url = URL(string: "App-Prefs:root=TOUCHID_PASSCODE")
            if UIApplication.shared.canOpenURL(url!) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url!)
                }
            }
            
        })
        present(alertController, animated: true, completion: nil)
    }
}
