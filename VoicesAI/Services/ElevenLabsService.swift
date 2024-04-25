//
//  ElevenLabsService.swift
//  VoicesAI
//
//  Created by MACBOOK PRO on 25/04/24.
//

import Foundation
class ElevenLabsService {
    private let apiKey: String
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func generateSpeech(for text: String) async throws -> Data {
        guard let url = URL(string: Constant.fullURL(forVoice: .Nico)) else {
            print("invalid URL")
            return Data()
        }
        
        print("You are using API_KEY \(apiKey) for request to ElevenLabs!")
        
        
        //Request Body
        
        let body: [String: Any] = [
            "model_id": "eleven_multilingual_v2",
            "text": text,
            "voice_settings":[
                "stability":0.5,
                "similarity_boost": 0.8
                
            ]
        ]
        let requestBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        //request url
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(apiKey, forHTTPHeaderField:"xi-api-key")
        request.httpBody = requestBody
        
        //Network request for POST data
        let(data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Failed request: \(response)")
            return Data()
        }
        
        
        guard (200...299).contains(httpResponse.statusCode) else {
            print("Server returned with status code : \(httpResponse.statusCode)")
            return Data()
        }
        
        guard !data.isEmpty else {
            print("No data receive from r")
            return Data()
        }
        
        
        return data
        
    }
    
}
