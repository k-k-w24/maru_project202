import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class MainLoginViewController: UIViewController {
    @IBOutlet weak var loginbutton1: CustomGradButton!
    @IBOutlet weak var register: CustomGradButton!
    @IBOutlet weak var GoogleReg: CustomGradButton!
    let Loginbutton: UIButton = UIButton()
    let myButton: UIButton = UIButton()
    @IBOutlet weak var LoginButton: CustomRightButton!
    
    @IBOutlet weak var labellogin: UILabel!
    let spinner = UIActivityIndicatorView(style: .whiteLarge)
    @IBAction func emailLoginTapped(_ sender: UIButton) {
        // emailLoginViewControllerへの遷移
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let emailLoginVC = storyboard.instantiateViewController(withIdentifier: "Login") as? LoginViewController {
            self.present(emailLoginVC, animated: true, completion: nil)
        }
    }
    
    
    
    override func viewDidLoad() {
        LoginButton.setTitle("ログイン", for: .normal)
        labellogin.font = UIFont(name: "pugnomincho-mini", size: 60)
        Loginbutton.frame = CGRectMake(0,0,200,40)
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.white.cgColor]
                gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
//                self.layer.insertSublayer(gradientLayer, at: 0)
        super.viewDidLoad()
        // サイズを設定する.
//        myButton.frame = CGRectMake(0,0,200,40)
//        
//        // 背景色を設定する.
//        myButton.backgroundColor = UIColor.blue
//        
//        // 枠を丸くする.
//        myButton.layer.masksToBounds = true
//        
//        // タイトルを設定する(通常時).
//        myButton.setTitle("Click Me", for: .normal)
//        myButton.setTitleColor(UIColor.white, for: .normal)
//        
//        // コーナーの半径を設定する.
//        myButton.layer.cornerRadius = 20.0
//        
//        // ボタンの位置を指定する.
//        myButton.layer.position = CGPoint(x: self.view.frame.width/2, y:200)
//        
//        // タグを設定する.
//        myButton.tag = 1
//        
//        // イベントを追加する.
//        myButton.addTarget(self, action: Selector("onClickMyButton:"), for: .touchUpInside)
//        
//        // タイトルを設定する(ボタンがハイライトされた時).
//        myButton.setTitle("Pushed!", for: .highlighted)
//        myButton.setTitleColor(UIColor.black, for: .highlighted)
//        
//        // ボタンをViewに追加する.
//        self.view.addSubview(myButton)
//        
//        // spinner 追加
//        spinner.frame = CGRect(x: -20, y: 6, width: 20, height: 20)
//        spinner.startAnimating()
//        spinner.alpha = 0.0
//        
//        myButton.addSubview(spinner)
        
//        
       // FirebaseとGoogle Sign-Inの初期化処理
        initializeFirebaseAndGoogleSignIn()
   }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 初期化処理
    private func initializeFirebaseAndGoogleSignIn() {
        // Google Sign-Inの初期化
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            print("Firebase ClientIDが見つかりません")
            return
        }
        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)
    }
    
    @IBAction func googleLoginTapped(_ sender: UIButton) {
        loginTapped()
    }
    @IBAction func registUser(_ sender: Any) {
        //独自サインイン機能
    }
    public func loginTapped(){
        // Googleログイン処理
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { result, error in
            if let error = error {
                print("Googleログインエラー: \(error.localizedDescription)")
                return
            }
            
            // GIDSignInResultの`user`プロパティからトークンを取得
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                print("トークンの取得に失敗しました")
                return
            }
            
            // Firebase認証用のクレデンシャルを作成
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebaseログインエラー: \(error.localizedDescription)")
                    return
                }
                
                // Firebaseログイン成功時の処理
                guard let firebaseUser = authResult?.user else {
                    print("Firebaseユーザー情報が取得できません")
                    return
                }
                
                print("ログイン成功: \(firebaseUser.email ?? "不明なメールアドレス")")
                print("名前: \(firebaseUser.displayName ?? "不明な名前")")
                print("UID: \(firebaseUser.uid)")
                
                // 次の画面に遷移する場合
                self.navigateToNextScreen()
            }
        }
    }
    
    // ログイン成功後の画面遷移
    private func navigateToNextScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let nextVC = storyboard.instantiateViewController(withIdentifier: "mainPage") as? MaruViewController {
            self.present(nextVC, animated: true, completion: nil)
        } else {
            print("次の画面が見つかりません")
        }
    }
    

    
    
}
    

