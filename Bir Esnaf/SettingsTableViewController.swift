//
//  SettingsTableViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 2.11.2023.
//

import UIKit
import ProgressHUD

class SettingsTableViewController: UITableViewController {

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showUserInfo() // refresh our page
    }

    //MARK: - TableView Delegates
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(named: "backgroundColor")
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0.0 : 12.0
    }
    
    
    //MARK: - IB Actions
    @IBAction func tellAFriendButton(_ sender: Any) {
        print("Arkadaşlara Öner")
    }
    
    @IBAction func termsAndCondButton(_ sender: Any) {
        print("Şartlar ve koşullar")
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        FirebaseUserListener.shared.logOutCurrentUser { error in
            if error == nil {
                let loginView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "loginView")
                DispatchQueue.main.async {
                    loginView.modalPresentationStyle = .fullScreen
                    self.present(loginView, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func deleteAccountButton(_ sender: Any) {
        FirebaseUserListener.shared.deleteAccountCurrentUser { error in
            if error == nil {
                ProgressHUD.success("Hesabınız Silindi.")
                let loginView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "loginView")
                DispatchQueue.main.async {
                    loginView.modalPresentationStyle = .fullScreen
                    self.present(loginView, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    //MARK: - UpdateUI
    private func showUserInfo() {
        if let user = User.currentUser {
            // burada yenileyeceğimiz şeyleri koyacağız işine yaramazsa sil geç.
        }
    }

    

    
}
