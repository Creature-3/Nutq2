//
//  SpeechSandboxView.swift
//  Nutq
//
//  Created by Rahaf Alhammadi on 16/06/1447 AH.
//

import SwiftUI

struct SpeechSandboxView: View {
    @StateObject private var speechService = SpeechRecognizerService()
    
    // We store only the symbol (e.g. "ب") to avoid any Hashable / Identifiable issues
    @State private var targetLetterSymbol: String = ArabicAlphabet.all.first?.symbol ?? "أ"
    
    // The letter we *think* the user said
    @State private var detectedLetter: Letter?
    
    // Helper to get the full target Letter from its symbol
    private var targetLetter: Letter? {
        ArabicAlphabet.all.first { $0.symbol == targetLetterSymbol }
    }
    
    var body: some View {
        VStack(spacing: 24) {
            Text("🎤 Speech Sandbox")
                .font(.title2.bold())
            
            // 1) Choose target letter
            VStack(spacing: 8) {
                Text("Target letter (what you asked for):")
                    .font(.subheadline)
                
                Picker("Letter", selection: $targetLetterSymbol) {
                    ForEach(ArabicAlphabet.all, id: \.symbol) { letter in
                        Text("\(letter.symbol)  -  \(letter.name)")
                            .tag(letter.symbol)
                    }
                }
                .labelsHidden()
                .pickerStyle(.wheel)
                .frame(height: 120)
            }
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            // 2) Mic button
            Button(action: {
                let wasRecording = speechService.isRecording
                
                // Toggle recording
                speechService.toggleRecording()
                
                if !wasRecording {
                    // We just STARTED recording → clear previous result
                    detectedLetter = nil
                }
            }) {
                ZStack {
                    Circle()
                        .fill(speechService.isRecording ? Color.red.opacity(0.7) : Color.green.opacity(0.7))
                        .frame(width: 90, height: 90)
                    
                    Image(systemName: speechService.isRecording ? "stop.fill" : "mic.fill")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            
            // 3) Show transcript
            VStack(alignment: .leading, spacing: 8) {
                Text("Transcript:")
                    .font(.subheadline.bold())
                
                Text(speechService.transcript.isEmpty ? "Say the letter name…" : speechService.transcript)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.black.opacity(0.05))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(.horizontal)
            
            // 4) Show detection result
            VStack(spacing: 8) {
                Text("Detected letter:")
                    .font(.subheadline.bold())
                
                if let detected = detectedLetter {
                    Text("\(detected.symbol) – \(detected.name)")
                        .font(.title3.bold())
                    
                    if let target = targetLetter, detected.symbol == target.symbol {
                        Text("✅ أحسنت! نطقتِ الحرف الصحيح 🌟")
                            .foregroundColor(.green)
                    } else if let target = targetLetter {
                        Text("❌ الحرف مختلف.\nالمطلوب: \(target.symbol) – \(target.name)")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.red)
                    } else {
                        Text("تم التعرف على حرف لكن لا يوجد حرف مستهدف محدد.")
                            .foregroundColor(.orange)
                    }
                } else {
                    if !speechService.transcript.isEmpty {
                        Text("🤔 لم أستطع معرفة أي حرف من الكلام.")
                            .foregroundColor(.secondary)
                    } else {
                        Text("لا يوجد حرف بعد.\nاختاري حرف واضغطي على الميكروفون ثم انطقي اسمه.")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        // 👇👇 THIS is the live-feedback part
        .onChange(of: speechService.transcript) { newValue in
            // Only care while recording
            guard speechService.isRecording else { return }
            
            // Try to detect letter from the current transcript
            detectedLetter = detectLetter(from: newValue)
            print("🎧 Live transcript:", newValue)
        }
    }
}

// MARK: - Detection helper
extension SpeechSandboxView {
    /// Super simple detection:
    /// - checks if transcript contains the letter symbol (e.g. "ب")
    /// - or the letter name (e.g. "باء")
    func detectLetter(from transcript: String) -> Letter? {
        let lower = transcript
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !lower.isEmpty else { return nil }
        
        return ArabicAlphabet.all.first { letter in
            lower.contains(letter.symbol) || lower.contains(letter.name)
        }
    }
}

// MARK: - Preview
struct SpeechSandboxView_Previews: PreviewProvider {
    static var previews: some View {
        SpeechSandboxView()
    }
}
