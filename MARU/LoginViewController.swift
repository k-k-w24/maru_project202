//
//  LoginViewController.swift
//  MARU
//
//  Created by 加藤小夏 on 2025/01/01.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var result: UITextField!
    @IBAction func loginButtonTappedGoogle(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let mainLoginVC = storyboard.instantiateViewController(withIdentifier: "MainLoginViewController") as? MainLoginViewController {
                    mainLoginVC.loginTapped()
                } else {
                    print("MainLoginViewControllerが見つかりません")
                }
    }

    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            print("メールアドレスとパスワードを入力してください")
            result.text  = "メールアドレスとパスワードを入力してください"
            return
        }
        
        
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("ログインエラー: \(error.localizedDescription)")
                return
            }
            print("ログイン成功: \(authResult?.user.email ?? "不明なメールアドレス")")
        }
        
        
    }
        
    
}

