import UIKit
import FirebaseAuth

class UserRegisterViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            print("メールアドレスとパスワードを入力してください")
            return
        }
        
        // ユーザー登録処理
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("登録エラー: \(error.localizedDescription)")
                return
            }
            
            print("登録成功: \(authResult?.user.email ?? "不明なメールアドレス")")
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            print("メールアドレスとパスワードを入力してください")
            return
        }
        
        // ログイン処理
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("ログインエラー: \(error.localizedDescription)")
                return
            }
            
            print("ログイン成功: \(authResult?.user.email ?? "不明なメールアドレス")")
        }
    }
}
