//
//  FaceManager.swift
//
//

import UIKit


enum FaceTypes {
    case rest
    case talk
}

class FaceManager {
    static let shared = FaceManager(animTime:0.1,faceType:.rest,faceImage: UIImageView())
    
    var animTime: TimeInterval = 0.1
    
    var faceType: FaceTypes = .rest
    var faceImage: UIImageView?
    
    init(animTime: TimeInterval, faceType:FaceTypes, faceImage: UIImageView?) {
          self.animTime = animTime
          self.faceType = faceType
        self.faceImage = faceImage 
      
  }

    let restingImages = [
        UIImage(named: "modok_rest_frame_01"),
        UIImage(named: "modok_rest_frame_02"),
        UIImage(named: "modok_rest_frame_03"),
        UIImage(named: "modok_rest_frame_04"),
        UIImage(named: "modok_rest_frame_01"),
        UIImage(named: "modok_rest_frame_02"),
        UIImage(named: "modok_rest_frame_03"),
        UIImage(named: "modok_rest_frame_04")
    ]
    
    let talkingImages = [
        UIImage(named: "modok_talk_frame_01"),
        UIImage(named: "modok_talk_frame_02"),
        UIImage(named: "modok_talk_frame_03"),
        UIImage(named: "modok_talk_frame_04"),
        UIImage(named: "modok_talk_frame_05")
    ]
    
    var restingIdx: Int = 0
    var talkingIdx: Int = 0
    
    @objc func animateFace() {
        // helper method to get the next appropriate animate for the animation timer
        switch faceType {
            case .talk:
            faceImage?.contentMode = .scaleAspectFit  // アスペクト比を維持して表示
           
            faceImage?.image = getTalkingFace()
            
            default: // .rest

            faceImage?.contentMode = .scaleAspectFit  // アスペクト比を維持して表示
            faceImage?.image = getRestingFace()
        }
    }
    
    func getRestingFace() -> UIImage? {
        restingIdx += 1
        if restingIdx == restingImages.count {
            restingIdx = 0
        }
        return restingImages[restingIdx]
    }
    
    func getTalkingFace() -> UIImage? {
        talkingIdx += 1
        if talkingIdx == talkingImages.count {
            talkingIdx = 0
        }
        return talkingImages[talkingIdx]
    }
}
