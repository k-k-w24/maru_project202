//
//  TopHello.swift
//
//  Created by 加藤小夏 on 2025/02/05.
//

import Foundation
import UIKit

class TopHello: UIViewController{
    
    @IBOutlet weak var maruNoHeyaLabel: UILabel!
    
    override func viewDidLoad() {
        maruNoHeyaLabel.font = UIFont(name: "pugnomincho-mini", size: 100)
        
        startBouncingLabel(maruNoHeyaLabel)
        view.backgroundColor = .clear
        
        setBackgroundImage()
    }
    func setBackgroundImage() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        view.isOpaque = false
        
        view.backgroundColor = .clear

        backgroundImage.image = UIImage(named: "background1.png") // 画像名を設定
        backgroundImage.contentMode = .scaleAspectFill // 画面いっぱいに表示
        view.insertSubview(backgroundImage, at: 0) // 一番奥に配置
    }
    
    func startBouncingLabel(_ label: UILabel) {
        UIView.animate(withDuration: 0.6,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 4,
                       options: [.curveEaseInOut, .allowUserInteraction]) {
            label.transform = CGAffineTransform(translationX: 0, y: -6.5) // 上に移動
        } completion: { _ in
            UIView.animate(withDuration: 0.6,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 4,
                           options: [.curveEaseInOut, .allowUserInteraction]) {
                label.transform = .identity // 元の位置に戻る
            } completion: { _ in
                self.startBouncingLabel(label) 
            }
        }
    }
}
