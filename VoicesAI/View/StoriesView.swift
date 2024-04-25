//
//  StoriesView.swift
//  VoicesAI
//
//  Created by MACBOOK PRO on 24/04/24.
//

import SwiftUI

struct StoriesView: View {
    @StateObject private var storyVM = StoryVM()
    @StateObject private var speechVM = SpeechVM()
    @State private var selectedTopic: Topics = .persahabatan
    @State private var selectedMood: Mood = .bahagia
    
    
    //@State private var todayStory: String = ""
    var body: some View {
        NavigationStack{
            Form{
                Section {
                    Picker("Choose topics", selection: $selectedTopic) {
                        ForEach(Topics.allCases, id: \.self) {topic in
                            Text(topic.rawValue)
                                .font(.subheadline)
                                .foregroundStyle(.primary)
                                .tag(topic)
                        }
                    }
                    
                    Picker("Choose mood", selection: $selectedMood) {
                        ForEach(Mood.allCases, id: \.self) {topic in
                            Text(topic.rawValue)
                                .font(.subheadline)
                        }
                    }
                }header: {
                    Text("Topics")
                }footer: {
                    Text("Choose any topics and mood that you want to listen.")
                    
                    
                }
                Section{
                    TextEditor(text: $storyVM.displayedStoryText)
                        .frame(height: 200)
                        .font(.system(.headline, design: .rounded))
                        .foregroundStyle(.blue)
                        .disabled(storyVM.isLoading)
                        .overlay {
                            storyVM.isLoading ? ProgressView() : nil
                        }
                }header: {
                    Text("Todays Story")
                }footer: {
                    Text("This stories are being produced by Gemini AI.")
                }
                
                
                // MARK : - BUTTON GENERATE
                Button {
                    todaysStory()
                }label: {
                    if storyVM.isLoading {
                        ProgressView().scaleEffect(1)
                    }else{
                        Text(storyVM.storyText.isEmpty ? "Generate".uppercased() : "Speech".uppercased())
                            .font(.system(.callout, design: .rounded))
                            .fontWeight(.bold)
                    }
                    
                        
                }
                .buttonStyle(PlainButtonStyle())
                .frame(minWidth: 0, maxWidth: .infinity)
                
                
            }
            .navigationTitle("Stories")
            .tint(.black)
        }
    }
}

#Preview {
    StoriesView()
}

// MARK : - PLAY SPEECH
extension StoriesView{
    func playSpeech() {
        let apiKey = UserDefaults.standard.string(forKey: "ElevenLabsAPIKey") ?? ""
        
        
        Task {
            await speechVM.generateAndPlaySpeech(from:storyVM.displayedStoryText,apiKey: apiKey)
        }
    }
    
    
    
    func generateStory() {
        Task{
          await  storyVM.generateStory(topic: selectedTopic, mood: selectedMood)
            
        }
        
    }
    
    private func todaysStory(){
        if storyVM.displayedStoryText.isEmpty{
            generateStory()
        }else{
            playSpeech()
        }
        
    }
}
