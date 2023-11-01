//
//  FirebaseUserListener.swift
//  Bir Esnaf
//
//  Created by Seyma on 25.10.2023.
//  10 - 14:39

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class FirebaseUserListener {
    static let shared = FirebaseUserListener()
    
    private init() {  }
    
    //MARK: - Login
    
    
    //MARK: - Register
    func registerUserWith(email: String, password: String, completion: @escaping(_ error: Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            completion(error)
            if error == nil {
                authResult!.user.sendEmailVerification { error in  // send verification email
                    print("Auth email send with error: ", error?.localizedDescription as Any)
                }
                
                // create user and save it
                if authResult?.user != nil {
                    let user = User(id: authResult!.user.uid, userName: email, email: email)
                    saveUserLocally(user)
                }
            }
        }
    }
    
    //MARK: - Save Users
    func saveUserToFirestore(_ user: User) {
        do {
            try FirebaseReference(.User).document(user.id).setData(from: user)
        } catch {
            
        }
    }
    
    
}


func saveUserLocally(_ user: User) {
    let encoder = JSONEncoder()
    do {
        let data = try encoder.encode(user)
        UserDefaults.standard.set(data, forKey: kcurrentUser)
    } catch {
        print("error saving user locally ", error.localizedDescription)
    }
    
}
