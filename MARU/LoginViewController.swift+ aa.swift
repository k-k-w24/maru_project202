import FirebaseUI

class LoginViewController: UIViewController, FUIAuthDelegate {
    @IBAction func googleLoginTapped(_ sender: UIButton) {
        let authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
        authUI?.providers = [FUIGoogleAuth()]

        let authViewController = authUI!.authViewController()
        present(authViewController, animated: true, completion: nil)
    }

    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if let error = error {
            print("Googleログインエラー: \(error.localizedDescription)")
            return
        }
        print("Googleログイン成功: \(authDataResult?.user.email ?? "不明なメールアドレス")")
    }
}
