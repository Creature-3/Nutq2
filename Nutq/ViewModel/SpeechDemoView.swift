import SwiftUI
import Speech
import AVFoundation

struct SpeechDemoView: View {
    @StateObject private var speech = SpeechRecognizer()
    
    let target: String   // <— THIS CHANGES per letter

        func isCorrect(_ transcript: String, target: String) -> Bool {
            let cleaned = transcript.trimmingCharacters(in: .whitespacesAndNewlines)
            return cleaned.contains(target)
        }

    var body: some View {
        VStack(spacing: 40) {

            Text("Say something…")
                .font(.title2)

            // ⬇️ Shows text from microphone
            Text(speech.transcript.isEmpty ? "Listening…" : speech.transcript)
                .padding()
                .frame(maxWidth: .infinity, minHeight: 120, alignment: .topLeading)
                .background(Color(.systemGray6))
                .cornerRadius(16)
                .font(.title3)

            Spacer()

            // 🎤 Mic button
            Button {
                if speech.isRecording {
                    speech.stopRecording()
                } else {
                    speech.startRecording()
                }
            } label: {
                ZStack {
                    Circle()
                        .fill(speech.isRecording ? Color.red : Color.blue)
                        .frame(width: 90, height: 90)

                    Image(systemName: speech.isRecording ? "stop.fill" : "mic.fill")
                        .font(.system(size: 36))
                        .foregroundColor(.white)
                }
            }

            Spacer()
        }
        .padding()
    }
}
