//
//  ViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 27.09.2023.
//

import UIKit

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
            // login or register
            print("have data for login/register")
        } else {
            // PogressHUD.showFiled("All fields are required")
            print("Hata login")
        }
    }
    
    @IBAction func forgotPasswordButtonPressed(_ sender: Any) {
        if isDataInputedFor(type: "password") {
            // reset password
            print("Have data for forgot pass")
        } else {
            // PogressHUD.showFiled("Email is required.")
            print("hata forgot pass")
        }
    }
    
    @IBAction func resendEmailButtonPressed(_ sender: Any) {
        if isDataInputedFor(type: "password") {
            // resend verification email
            print("have data for resend email")
        } else {
            // PogressHUD.showFiled("Email is required.")
            print("hata resend mail")
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
    
}

