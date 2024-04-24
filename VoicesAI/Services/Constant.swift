//
//  Constant.swift
//  VoicesAI
//
//  Created by MACBOOK PRO on 24/04/24.
//

import Foundation

struct Constant {
    
    static let baseURL = "https://api.elevenlabs.io/"
    static let appVersion = "v1"
    
    enum Endpoint: String {
        case textToSpeech = "text-to-speech"
        case speechToSpeech = "speech-to-speech"
        
        
    }
    
    
    enum VoiceID: String {
        case Wordsworth = "BjtEYj51IjAqBMKxZhX7"
        case Nico       = "1ns94GwK9YDCJoL6Nglv"
        
        
    }
    ///"https://api.elevenlabs.io/v1/text-to-speech/1ns94GwK9YDCJoL6Nglv"
    static func fullURL(forVoice voice: VoiceID)-> String {
        let results = baseURL + appVersion + "/" + Endpoint.textToSpeech.rawValue + "/" + voice.rawValue
        
        return results
    }
    
}
