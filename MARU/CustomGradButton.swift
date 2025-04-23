//
//  CustomButoon.swift
//
//  Created by 加藤小夏 on 2025/02/05.
//

import Foundation


import UIKit
class CustomGradButton: UIButton {
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
  
  private func customDesign() {
    // デザインのカスタマイズ内容
      // すでにグラデーションレイヤーがある場合は削除
      backgroundColor = .clear
      tintColor = .clear
      setTitleColor(.white, for: .normal)
      titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
      contentEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
      layer.cornerRadius = 15.0
      layer.masksToBounds = true;
      let gradientLayer = CAGradientLayer()
      gradientLayer.frame = bounds;
      gradientLayer.colors = [UIColor(displayP3Red: 0/255, green: 172/255, blue: 254/255,alpha: 1.0).cgColor, UIColor(displayP3Red: 79/255, green: 242/255, blue: 254/255,alpha: 1.0).cgColor]
      layer.insertSublayer(gradientLayer, at:0)
  }
}
