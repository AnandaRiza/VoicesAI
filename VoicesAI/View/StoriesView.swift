//
//  StoriesView.swift
//  VoicesAI
//
//  Created by MACBOOK PRO on 24/04/24.
//

import SwiftUI

struct StoriesView: View {
    @State private var selectedTopic: Topics = .persahabatan
    @State private var selectedMood: Mood = .bahagia
    
    @State private var todayStory: String = ""
    var body: some View {
        NavigationStack{
            Form{
                Section {
                    Picker("Choose topics", selection: $selectedTopic) {
                        ForEach(Topics.allCases, id: \.self) {topic in
                            Text(topic.rawValue.capitalized)
                                .font(.subheadline)
                                .foregroundStyle(.primary)
                                .tag(topic)
                        }
                    }
                    
                    Picker("Choose mood", selection: $selectedMood) {
                        ForEach(Mood.allCases, id: \.self) {topic in
                            Text(topic.rawValue.capitalized)
                                .font(.subheadline)
                        }
                    }
                }header: {
                    Text("Topics")
                }footer: {
                    Text("Choose any topics and mood that you want to listen.")
                    
                    
                }
                Section{
                    TextEditor(text: $todayStory)
                        .frame(height: 200)
                        .font(.system(.headline, design: .rounded))
                        .foregroundStyle(.blue)
                }header: {
                    Text("Todays Story")
                }footer: {
                    Text("This stories are being produced by Gemini AI.")
                }
                
                
                // MARK : - BUTTON GENERATE
                Button {
                    //TODO
                }label: {
                    Text("Generate".uppercased())
                        .font(.system(.callout, design: .rounded))
                        .fontWeight(.bold)
                        
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
