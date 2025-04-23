//
//  MaruViewController.swift
//

import UIKit
import Speech

extension MaruViewController {
    
    func speak(_ speechString: String) {
        var str = speechString

        for (key, val) in valuesHeard {
            str = str.replacingOccurrences(of: "%%\(key)%%", with: val)
        }
        
        print ("MARU: \(str)\n")
        
        subtitleLabel?.text = ""
        subtitleLabel?.isHidden = false
        
        let speechUtterance = AVSpeechUtterance(string: str)
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
        speechUtterance.volume = 1.0
        speechUtterance.rate = 0.1
        speechUtterance.pitchMultiplier = 2.0
        
        speechSynthesizer.speak(speechUtterance)
    }
    
}
