//
//  SignInViewController.swift
//  SignUpScreen
//
//  Created by ket on 6/7/19.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

private struct SignInConstans {
    static let mainStringForgotYourPasswordLabel = "Forgot your password? "
    static let orangeStringForgotYourPasswordLabel = "Tap to reset"
    static let goToSignUpSegueIdentifire = "goToSignUp"
    static let emailPredicate = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    static let passwordMin = 6
    static let passwordMax = 16
    static let startButtonEnableBackgroundColor = #colorLiteral(red: 0.9287405014, green: 0.4486459494, blue: 0.01082476228, alpha: 1)
    static let startButtonDisableBackgroundColor = #colorLiteral(red: 0.9385811687, green: 0.6928147078, blue: 0.4736688733, alpha: 1)
}


class SignInViewController: BaseViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var forgotYourPasswordLabel: UILabel!
    @IBOutlet weak var incorrectPasswordLabel: UILabel!
    
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var showPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupForgotYourPasswordLabel()
    }
    
    override func performToSegue() {
        performSegue(withIdentifier: SignInConstans.goToSignUpSegueIdentifire, sender: self)
    }
    
    override func settingTextFields() {
        super.setPaddingForTextField(emailTextField)
        super.setPaddingForTextField(passwordTextField)
    }
    
    @IBAction func tapStartButton(_ sender: UIButton) {
    }
    
    @IBAction func changePasswordMode(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func unwindToSignIn(segue: UIStoryboardSegue) {}
    
}

extension SignInViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return false }
        
        if textField == emailTextField {
            if SignInConstans.emailPredicate.evaluate(with: updatedString) && passwordTextField.text?.count ?? 0 >= SignInConstans.passwordMin && passwordTextField.text?.count ?? 0 <= SignInConstans.passwordMax {
                self.startButton.backgroundColor = SignInConstans.startButtonEnableBackgroundColor
                self.startButton.isEnabled = true
            } else {
                self.startButton.backgroundColor = SignInConstans.startButtonDisableBackgroundColor
                self.startButton.isEnabled = false
            }
            
        } else if textField == passwordTextField {
            if updatedString.count >= SignInConstans.passwordMin && updatedString.count <= SignInConstans.passwordMax {
                self.incorrectPasswordLabel.isHidden = true
                self.passwordTextField.layer.borderWidth = 0
                if SignInConstans.emailPredicate.evaluate(with: emailTextField.text) {
                    self.startButton.backgroundColor = SignInConstans.startButtonEnableBackgroundColor
                    self.startButton.isEnabled = true
                } else {
                    self.startButton.backgroundColor = SignInConstans.startButtonDisableBackgroundColor
                    self.startButton.isEnabled = false
                }
                
            } else {
                self.incorrectPasswordLabel.isHidden = false
                self.startButton.backgroundColor = SignInConstans.startButtonDisableBackgroundColor
                self.startButton.isEnabled = false
            }
        }
        
        
        if updatedString.count > 0 {
            self.showPasswordButton.isHidden = false
            self.showPasswordButton.isEnabled = true
        } else {
            self.showPasswordButton.isHidden = true
            self.showPasswordButton.isEnabled = false
            self.passwordTextField.isSecureTextEntry = true
            self.incorrectPasswordLabel.isHidden = true
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        super.makeGreyBorder(textField: textField)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return super.goToTheNext(textField: textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        super.hideBorder(textField: textField)
    }
    
}

private extension SignInViewController {
    
    func setupForgotYourPasswordLabel() {
        super.makeTheSubstringOrange(label: self.forgotYourPasswordLabel, mainString: SignInConstans.mainStringForgotYourPasswordLabel, subStringForColoring: SignInConstans.orangeStringForgotYourPasswordLabel)
    }
    
}

