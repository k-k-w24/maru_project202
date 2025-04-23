import UIKit

class CustomRightButton: UIButton {

    private var gradientLayer: CAGradientLayer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        customDesign()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customDesign()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        customDesign()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // グラデーションレイヤーのフレームを更新
        gradientLayer?.frame = bounds
    }

    private func customDesign() {
        // 背景を透明に
        backgroundColor = .clear
        tintColor = .clear

        // タイトルのスタイル
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)

        // パディングと角丸
        contentEdgeInsets = UIEdgeInsets(top: 12, left: 20, bottom: 12, right: 20)
        layer.cornerRadius = 20.0
        layer.masksToBounds = true

        // グラデーションレイヤー
        gradientLayer = CAGradientLayer()
        gradientLayer?.colors = [
            UIColor(displayP3Red: 173/255, green: 216/255, blue: 230/255, alpha: 1.0).cgColor, // ライトブルー
            UIColor(displayP3Red: 135/255, green: 206/255, blue: 250/255, alpha: 1.0).cgColor  // スカイブルー
        ]
        gradientLayer?.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer?.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer?.cornerRadius = layer.cornerRadius

        if let gradientLayer = gradientLayer {
            // グラデーションをレイヤーの最背面に追加
            layer.insertSublayer(gradientLayer, at: 0)
        }

        // シャドウを追加して立体感を出す
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 4.0
        layer.masksToBounds = false

        // テキストを最前面に持ってくる
        bringSubviewToFront(titleLabel ?? UIView())
    }
}
