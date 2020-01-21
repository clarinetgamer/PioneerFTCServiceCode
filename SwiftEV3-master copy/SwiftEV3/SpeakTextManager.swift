//
//  SpeakTextManager.swift
//  SwiftEV3
//
//  Created by CFHS-FTC on 11/3/19.
//  Copyright © 2019 謝飛飛. All rights reserved.
//

import AVFoundation

class SpeakTextManager {
    static var shared = SpeakTextManager()
    
    let synthesizer = AVSpeechSynthesizer()
    
    func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = 0.5
        
        synthesizer.speak(utterance)
    }
}
