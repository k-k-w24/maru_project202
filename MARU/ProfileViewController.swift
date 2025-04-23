import UIKit

class ProfileViewController: UIViewController {
    //    @IBOutlet weak var userIdTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userYear: UITextField!
    @IBOutlet weak var userMonth: UITextField!
    @IBOutlet weak var userDay: UITextField!
    @IBOutlet weak var userGen: UITextField!
    var userIdTextField = ""
    @IBOutlet weak var themelabel: UILabel!
    @IBOutlet weak var genlabel: UILabel!
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var barthlabel: UILabel!
    @IBOutlet weak var personallabel: UILabel!
    @IBOutlet weak var resultlabel: UILabel!
    @IBOutlet weak var yearlabel: UILabel!
    @IBOutlet weak var monthlabel: UILabel!
    @IBOutlet weak var daylabel: UILabel!
    
    @IBOutlet weak var userDataTextField: UITextField!
    
    @IBOutlet weak var finishButton: UIButton!
    
    
    override func viewDidLoad() {
        a()

        finishButton.titleLabel?.font = UIFont(name: "pugnomincho-mini", size: 17)
        themelabel.font = UIFont(name: "pugnomincho-mini", size: 17)
        genlabel.font = UIFont(name: "pugnomincho-mini", size: 17)
        namelabel.font = UIFont(name: "pugnomincho-mini", size: 17)
        barthlabel.font = UIFont(name: "pugnomincho-mini", size: 17)
        personallabel.font = UIFont(name: "pugnomincho-mini", size: 17)
        resultlabel.font = UIFont(name: "pugnomincho-mini", size: 17)
        yearlabel.font = UIFont(name: "pugnomincho-mini", size: 17)
        monthlabel.font = UIFont(name: "pugnomincho-mini", size: 17)
        daylabel.font = UIFont(name: "pugnomincho-mini", size: 17)
        super.viewDidLoad()
    }
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        userIdTextField = generateRandomNumericString(length: 3)
        
        
        guard let userData = userDataTextField.text ,
              let userYear = userYear.text ,
              let userMonth = userMonth.text ,
              let userDay = userDay.text ,
              let userGen = userGen.text
        else {
            resultLabel.text = "入力してください"
            return
        }
        
        // APIリクエストを送信
        sendDataToAPI(userId: userIdTextField, userYear: userYear, userMonth: userMonth, userDay: userDay, userGen: userGen, userData: userData)
    }
    
    func generateRandomNumericString(length: Int) -> String {
        let digits = "0123456789"
        return String((0..<length).map { _ in digits.randomElement()! })
    }
    func sendDataToAPI(userId: String, userYear: String, userMonth: String, userDay: String, userGen: String, userData: String) {
        let url = URL(string: "http://localhost:3000/users")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // JSONデータを作成
        let parameters: [String: Any] = [
            "user": [
                "USERID": userId,
                "USERBIRTH_YEAR": userYear,
                "USERBIRTH_MON":userMonth,
                "USERBIRTH_DAY": userDay,
                "GEN": userGen,
                "DATA": userData
            ]
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            resultLabel.text = "JSON作成エラー"
            return
        }
        
        // APIリクエストを送信
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.resultLabel.text = "通信エラー: \(error.localizedDescription)"
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    self.resultLabel.text = "APIエラー"
                    return
                }
                
                self.resultLabel.text = "データを送信しました！"
                // **フィールドのリセット**
                self.resetFields()
            }
        }
        task.resume()
    }
    // フィールドリセット用のメソッド
    func resetFields() {
        //label.userIdTextField = User.label      // ユーザーIDフィールドをリセット
        userDataTextField.text = ""    // データフィールドをリセット
    }
    
    func a(){
        finishButton.titleLabel?.font = UIFont(name: "pugnomincho-mini", size: 17)
        var config = UIButton.Configuration.filled()
        config.title = "おわり"
        
        // フォントの変更
        var titleAttr = AttributeContainer()
        titleAttr.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        config.attributedTitle = AttributedString("おわり", attributes: titleAttr)
        
        finishButton.configuration = config
    }
}

// commit test
