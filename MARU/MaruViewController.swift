//
//  MaruViewController.swift
//

import UIKit
import Speech

class MaruViewController: UIViewController {
    
    // Speech recognition
    let audioEngine = AVAudioEngine()
    let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ja-JP"))!
    var recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    var speechSynthesizer = AVSpeechSynthesizer()
    var node: AVAudioInputNode?
    var locale: String = "ja-JP"
    
    var talkString: String = ""
    var talkingTimer: Timer?
    var pauseTime: TimeInterval = 4.0
    
    // Dialogue (conversational management)
    var goodbyeHeard: Bool = true 
    var unaskedQuestionsIndexes: [Int] = [] // index within Dialogue.shared.dialogue
//    var currentQuestion: Dialogue?
    var valuesHeard: [String: String] = [:]
    
    // Face animation
    var faceAnimationTimer: Timer?
    var faceManager = FaceManager(animTime: 0.2, faceType: .rest,faceImage: UIImageView())
    
    // UI
    @IBOutlet var faceImage: UIImageView?
    @IBOutlet var subtitleLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        speechRecognizer.delegate = self
        speechSynthesizer.delegate = self
        
        requestTranscribePermissions()
        
        startAudio()
        
        FaceManager.shared.faceImage = faceImage
        let customFaceManager = FaceManager(animTime: 0.2, faceType: .rest, faceImage: faceImage)


            faceAnimationTimer = Timer.scheduledTimer(timeInterval: faceManager.animTime, target: customFaceManager, selector: #selector(customFaceManager.animateFace), userInfo: nil, repeats: true)
        
        
    }

}
