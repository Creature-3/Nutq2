import Foundation
import Combine

class LetterPracticeViewModel: ObservableObject {
    @Published var selectedLetter: Letter
    @Published var transcript: String = ""
    @Published var feedback: String = ""
    @Published var isRecording: Bool = false

    private let speechRecognizer = SpeechRecognizer()

    private var cancellables = Set<AnyCancellable>()

    init(letter: Letter) {
        self.selectedLetter = letter

        // bind SpeechRecognizer -> ViewModel
        speechRecognizer.$transcript
            .receive(on: DispatchQueue.main)
            .sink { [weak self] text in
                self?.transcript = text
                self?.updateFeedback()
            }
            .store(in: &cancellables)

        speechRecognizer.$isRecording
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.isRecording = value
            }
            .store(in: &cancellables)
    }

    // MARK: - Actions

    func toggleRecording() {
        if isRecording {
            speechRecognizer.stopRecording()
        } else {
            feedback = ""          // clear old feedback
            transcript = ""
            speechRecognizer.startRecording()
        }
    }

    // MARK: - Logic

    private func updateFeedback() {
        guard !transcript.isEmpty else {
            feedback = ""
            return
        }

        let cleaned = transcript.replacingOccurrences(of: " ", with: "")

        // 1) Did we say the correct letter or its name?
        if cleaned.contains(selectedLetter.symbol) || cleaned.contains(selectedLetter.name) {
            feedback = "✅ ممتاز! نطقت حرف \(selectedLetter.symbol) بشكل صحيح."
            return
        }

        // 2) Try to detect which letter was actually said
        if let other = detectOtherLetter(in: cleaned) {
            feedback = "❌ سمعت حرف \(other.symbol) (\(other.name)) بدل \(selectedLetter.symbol). جرّب مرة أخرى."
        } else {
            feedback = "❌ ما قدرت أفهم الحرف، حاول تنطقه مرة ثانية بوضوح."
        }
    }

    private func detectOtherLetter(in text: String) -> Letter? {
        // Look for any other letter name or symbol in the transcript
        for letter in ArabicAlphabet.all where letter != selectedLetter {
            if text.contains(letter.symbol) || text.contains(letter.name) {
                return letter
            }
        }
        return nil
    }
}
