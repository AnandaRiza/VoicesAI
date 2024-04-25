//
//  SettingsView.swift
//  VoicesAI
//
//  Created by MACBOOK PRO on 24/04/24.
//

import SwiftUI

struct SettingsView: View {
    @State private var geminiAIKey = ""
    @State private var elevenLabsKey = ""
    
    let signUpGemini = "https://ai.google.dev"
    let signUpElevenLabs = "https://elevenlabs.io/api"
    var body: some View {
    
        
        NavigationStack{
            Form{
                Section {
                TextField("Gemini AI Key", text: $geminiAIKey)
                        .onAppear{
                            geminiAIKey = UserDefaults.standard.string(forKey: "GeminiAIKey") ?? ""
                        }
                TextField("Eleven Labs Key", text: $elevenLabsKey)
                        .onAppear{
                            elevenLabsKey = UserDefaults.standard.string(forKey: "ElevenLabsAIKey") ?? ""
                        }
                } header: {
                    Text("API KEYS")
                } footer: {
                    Text("Please input your API KEY ")
                }

                // MARK : - LINK
                Section {
                Link("GET GEMINI AI API KEY", destination: URL(string: signUpGemini)!)
                        .foregroundStyle(.blue)
                Link("GET ELEVEN LABS API KEY", destination: URL(string: signUpElevenLabs)!)
                        .foregroundStyle(.blue)
                } header: {
                    Text("DON'T HAVE API KEY ?")
                } footer: {
                    Text("Sign up to get your own API key via link above ")
                }
            }
            
            .navigationTitle("Configuration")
            .navigationBarTitleDisplayMode(.inline)
            
            // MARK : - SAVE KEY
            .toolbar{
                Button{
                    saveKey()
                } label: {
                    Text("Save")
                }
                .padding(.trailing, 8)
                .disabled(geminiAIKey.isEmpty || elevenLabsKey.isEmpty)
            }
            
        }
        
    }
}

#Preview {
    SettingsView()
}


extension SettingsView {
    func saveKey() {
        UserDefaults.standard.set(geminiAIKey, forKey: "GeminiAIKey")
        UserDefaults.standard.set(elevenLabsKey, forKey: "ElevenLabsAIKey")
    }
}
