//
//  BaseVC.swift
//  SecretSanta
//
//  Created by DAO VAN UOC on 11/26/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {
    
//    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = COLOR.APP_COLOR
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "ic_Header"), for: .default)
////        interstitial = GADInterstitial(adUnitID: kAdmobInterstitial)
//        let request = GADRequest()
//        interstitial.load(request)
//        interstitial.present(fromRootViewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func hideLeftButton() -> Void {
        self.navigationItem.hidesBackButton = true
    }

    func setupBackButton() -> Void {
        let image = UIImage(named: "ic_Back")?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: image, style: .plain, target: self, action: #selector(doBack))
    }
    
    func setupDoneButton() -> Void {
        let rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doDone))
        rightBarButtonItem.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func setupSettingButton() -> Void {
        let rightBarButtonItem = UIBarButtonItem(title: "Setting", style: .plain, target: self, action: #selector(doSetting))
        rightBarButtonItem.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = rightBarButtonItem
    }
    
    func setupAddButton() -> Void {
        let image = UIImage(named: "ic_Add")?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: image, style: .plain, target: self, action: #selector(doAdd))
    }
    
    func setupTitleNavi(title:String) -> Void {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        self.navigationItem.title = title
    }
    
    @objc func doBack() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func doDone() -> Void {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func doAdd() -> Void {
        
    }
    
    @objc func doSetting() -> Void {
        
    }
    
    
    
    // MARK: - KEYBOARD
    var hideKeyboardTap:UITapGestureRecognizer!
    var keyboardHidden = true
    // Use at the screen have scroll
    var rectTextFieldBeginEditing:CGRect! = CGRect.zero
    
    // MARK: Notification Center
    func createNotificationCenterKeyBoard() {
        // Keyboard
        hideKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(BaseVC.tapScreen))
        
        NotificationCenter.default.addObserver(self, selector: #selector(willShowKeyBoard(notification:) ), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willHideKeyBoard(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    // MARK: Show Keyboard
    @objc func willShowKeyBoard(notification : NSNotification){
        keyboardHidden = false
        let userInfo: NSDictionary! = notification.userInfo as NSDictionary!
        
        var duration : TimeInterval = 0
        
        duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        let keyboardFrame = (userInfo.object(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue).cgRectValue
        
        handleKeyboardWillShow(duration: duration,keyBoardRect: keyboardFrame, userInfo: userInfo)
        
        // Add action 'hideKeyboardTap' when user tap screen
        self.view.addGestureRecognizer(hideKeyboardTap)
    }
    
    // MARK: Hide Keyboard
    @objc func willHideKeyBoard(notification : NSNotification){
        keyboardHidden = true
        var userInfo: NSDictionary!
        userInfo = notification.userInfo as NSDictionary!
        
        var duration : TimeInterval = 0
        duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        let keyboardFrame = (userInfo.object(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue).cgRectValue
        
        handleKeyboardWillHide(duration: duration, keyBoardRect: keyboardFrame, userInfo: userInfo)
        
        // Remove action 'hideKeyboardTap' when user tap screen
        self.view.removeGestureRecognizer (hideKeyboardTap)
        // Enable UINavigationController
        //        if let navigationController = self.navigationController {
        //            navigationController.navigationBar.isUserInteractionEnabled = true
        //        }
    }
    
    // MARK: Action of Keyboard
    func handleKeyboardWillShow(duration: TimeInterval, keyBoardRect: CGRect, userInfo: NSDictionary) {
        
        // Find which textField is focused
        let offset = (self.rectTextFieldBeginEditing.origin.y + self.rectTextFieldBeginEditing.size.height) - (UIScreen.main.bounds.height - (keyBoardRect.size.height)) + 20/*bonus*/

        if offset > 0 {
            UIView.animate(withDuration: duration, delay: 0, options: [], animations: { [weak self] in
                guard let strongSelf = self else { return }
                
                strongSelf.view.frame.origin.y = 0 - 216
                }, completion: { (success) in
                    self.rectTextFieldBeginEditing = CGRect.zero
            })
        }
    }

    func handleKeyboardWillHide(duration: TimeInterval, keyBoardRect: CGRect, userInfo: NSDictionary) {
        
        UIView.animate(withDuration: duration, delay: 0, options:[], animations: { [weak self] in
            guard let strongSelf = self else { return }
            if strongSelf.navigationController == nil {
                strongSelf.view.frame.origin.y = 0
            } else {
                strongSelf.view.frame.origin.y = 64
            }
            }, completion: nil)
    }
    @objc func tapScreen() {
        if !keyboardHidden {
            self.view.endEditing(true)
        }
    }
    
    func setStatusBarBackgroundColor(color: UIColor) {
        
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        
        statusBar.backgroundColor = color
    }
}
