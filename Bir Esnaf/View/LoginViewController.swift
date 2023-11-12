//
//  ViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 27.09.2023.
//

import UIKit
import FirebaseFirestore
import ProgressHUD

class LoginViewController: UIViewController {

    //MARK: - IBOutlets
    // label
    @IBOutlet weak var emailLabelOutlet: UILabel!
    @IBOutlet weak var passwordLabelOutlet: UILabel!
    @IBOutlet weak var repeatPasswordLabelOutlet: UILabel!
    @IBOutlet weak var signUpLabel: UILabel!
    // textField
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    // button
    @IBOutlet weak var loginButtonOutlet: UIButton!
    @IBOutlet weak var signUpButtonOutlet: UIButton!
    @IBOutlet weak var resendEmailButtonOutlet: UIButton!
    // views
    @IBOutlet weak var repeatPasswordLineView: UIView!
    
    
    
    //MARK: - Vars
    var isLogin: Bool = true

    
    
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        updateUIFor(login: true)
        setupTextFieldDelegates()
        setupBackgroundTap()
    }

    
    
    
    //MARK: - IBActions
    @IBAction func loginButtonPressed(_ sender: Any) {
        if isDataInputedFor(type: isLogin ? "login" : "register") {
            isLogin ? loginUser() : registerUser()   // login or register func
        } else {
            // PogressHUD.showFiled("All fields are required")
            print("Tüm alanları doldurun.")
        }
    }
    
    @IBAction func forgotPasswordButtonPressed(_ sender: Any) {
        if isDataInputedFor(type: "password") {
            // reset password
            resetPassword()
        } else {
            // PogressHUD.showFiled("Email is required.")
            ProgressHUD.failed("Email adresi gerekli")
        }
    }
    
    @IBAction func resendEmailButtonPressed(_ sender: Any) {
        if isDataInputedFor(type: "password") {
            // resend verification email
            resendVerificationEmail()
        } else {
            // PogressHUD.showFiled("Email is required.")
            ProgressHUD.failed("Email adresi gerekli")
        }
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        updateUIFor(login: sender.titleLabel?.text == "Giriş yapın")
        isLogin.toggle()
    }
    
    
    
    //MARK: - Setup
    private func setupTextFieldDelegates() {
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_ :)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_ :)), for: .editingChanged)
        repeatPasswordTextField.addTarget(self, action: #selector(textFieldDidChange(_ :)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        updatePlaceholderLabels(textField: textField)
    }
    
    private func setupBackgroundTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func backgroundTap() {
        view.endEditing(false)
    }
    
    
    
    //MARK: - Animation
    private func updateUIFor(login: Bool) {
        loginButtonOutlet.setTitle(login ? "GİRİŞ" : "KAYIT" , for: .normal)
        signUpButtonOutlet.setTitle(login ? "Kayıt olun" : "Giriş yapın", for: .normal)
        signUpLabel.text = login ? "Bir hesabınız yok mu?" : "Bir hesabınız var mı?"
        UIView.animate(withDuration: 0.5) {
            self.repeatPasswordTextField.isHidden = login
            self.repeatPasswordLabelOutlet.isHidden = login
            self.repeatPasswordLineView.isHidden = login
        }
    }
    
    private func updatePlaceholderLabels(textField: UITextField) {
        switch textField {
        case emailTextField:
            emailLabelOutlet.text = textField.hasText ? "Email" : ""
        case passwordTextField:
            passwordLabelOutlet.text = textField.hasText ? "Şifre" : ""
        default:
            repeatPasswordLabelOutlet.text = textField.hasText ? "Şifre (Tekrar)" : ""
        }
    }
    
    
    //MARK: - Helpers
    private func isDataInputedFor(type: String) -> Bool {
        switch type {
        case "login":
            return emailTextField.text != "" && passwordTextField.text != ""
        case "register":
            return emailTextField.text != "" && passwordTextField.text != "" && repeatPasswordTextField.text != ""
        default:
            return emailTextField.text != ""
        }
    }
    
    private func loginUser() {
        FirebaseUserListener.shared.loginUserWithEmail(email: emailTextField.text!, password: passwordTextField.text!) { error, isEmailVerified in
            if error == nil {
                if isEmailVerified {
                    // go to app
                    //self.goToApp()
                    print("User has logged in with email ", User.currentUser?.email)
                    // table view a giderken buradan bir true gönder. 
                } else {
                    ProgressHUD.error("Lütfen emailinizi doğrulayın.")
                    self.resendEmailButtonOutlet.isHidden = false
                }
            } else {
                ProgressHUD.error(error!.localizedDescription)
            }
        }
    }
    
    private func registerUser() {
        if passwordTextField.text! == repeatPasswordTextField.text! {
            FirebaseUserListener.shared.registerUserWith(email: emailTextField.text!, password: passwordTextField.text!) { error in
                if error == nil {
                    ProgressHUD.success("Doğrulama için email adresinize gidin.")
                    self.resendEmailButtonOutlet.isHidden = false
                } else {
                    ProgressHUD.error(error!.localizedDescription)
                }
            }
        } else {
            ProgressHUD.error("Parolalar Eşleşmiyor!")
        }
    }
    
    private func resetPassword() {
        FirebaseUserListener.shared.resetPasswordFor(email: emailTextField.text!) { error in
            if error == nil {
                ProgressHUD.success("Sıfırlama maili gönderildi.")
            } else {
                ProgressHUD.error(error!.localizedDescription)
            }
        }
    }
    
    private func resendVerificationEmail() {
        FirebaseUserListener.shared.resendVerificationEmail(email: emailTextField.text!) { error in
            if error == nil {
                ProgressHUD.success("Yeni doğrulama emaili gönderildi.")
            } else {
                ProgressHUD.error("Lütfen daha sonra tekrar deneyin, hata \(error!.localizedDescription)")
                print(error!.localizedDescription)
            }
        }
    }
    
    //MARK: - Navigation
    private func goToApp() {
        let mainView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainView") as! UITabBarController
        
        mainView.modalPresentationStyle = .fullScreen
        self.present(mainView, animated: true, completion: nil)
    }
    
}

