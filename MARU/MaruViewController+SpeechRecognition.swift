//
//  MaruViewController.swift
//

import UIKit
import Speech

extension MaruViewController {

    func requestTranscribePermissions() {

        SFSpeechRecognizer.requestAuthorization { authStatus in
            DispatchQueue.main.async {
                if authStatus == .authorized {
                    print("Good to go!")
                } else {
                    print("Transcription permission was declined.", authStatus.rawValue)
                }
            }
        }
    }
    
    func startAudio() {
        print ("start listening for audio")
        
        AVAudioSession.initialize()
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            try audioSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
            
            DispatchQueue.main.async {
                self.startListening()
            }
        } catch {
            print ("an audio session error has occurred")
        }
    }
    
    func startListening() {
        stopRecognition()
        UIView.animate(withDuration: 0.2) {
            self.subtitleLabel?.isHidden = true
        }
        print ("start listening")
        if self.speechRecognizer.isAvailable {
            // Use the speech recognizer
            do {
                try startRecording()
            } catch {
                print ("Error with recording")
            }
        }
    }
    
    func startRecording() throws {
        stopRecognition()
        print ("start recording")
        audioEngine.reset()
        node = audioEngine.inputNode
        let recordingFormat = node?.outputFormat(forBus: 0)
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        node?.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            self.recognitionRequest.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
        
        recognitionTask = speechRecognizer.recognitionTask(with: self.recognitionRequest) { result, error in
            if let result = result {
                self.talkString = result.bestTranscription.formattedString
            }
            
            // after a 0.8 pause, consider the sentence completed
            self.pauseTillTalkingIsDone()

            
        }
    }
    
    func pauseTillTalkingIsDone() {
        stopRecognition()
        DispatchQueue.main.async {
            self.talkingTimer?.invalidate()
            self.talkingTimer = nil
            
            self.talkingTimer = Timer.scheduledTimer(timeInterval: self.pauseTime, target: self, selector: #selector(self.checkIfFinishedTalking), userInfo: nil, repeats: false)
        }
    }
    
    @objc func checkIfFinishedTalking() {
        print ("talking timer fired")
        if self.talkString == "" {
            // continue listening for a response
            pauseTillTalkingIsDone()
        } else {
            // stop listening and process what was said
            DispatchQueue.main.async {
                self.talkingTimer?.invalidate()
                self.talkingTimer = nil
                self.stopListening()
                let usertalk = self.talkString.lowercased()
                print ("User: "+usertalk+"\n")
                Task {
                    let response = await Task.detached {
                        return await self.fetchOpenAIResponse(str: usertalk)
                    }.value
                    self.sendUserMessage(str: response)
                }
                self.talkString = ""
            }
        }
    }

    
    func stopListening() {
        print ("stop recording/listening")
        node?.removeTap(onBus: 0)
        audioEngine.stop()
        recognitionRequest.endAudio()
        recognitionTask?.cancel()
    }
    
}


extension MaruViewController: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            
            FaceManager.shared.faceType = .rest
            
            self.startListening()
        }
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            FaceManager.shared.faceType = .talk
            
            let str = String(utterance.speechString)
            let range = Range(characterRange, in: str)!
            
            self.subtitleLabel?.text = (self.subtitleLabel?.text ?? "") + " " + str[range]
        }
        
    }
    func stopRecognition() {
            recognitionTask?.cancel()
            recognitionTask = nil

         recognitionRequest.endAudio()


            audioEngine.stop()
            audioEngine.inputNode.removeTap(onBus: 0)
        }
}

extension MaruViewController: SFSpeechRecognizerDelegate {
    
}
