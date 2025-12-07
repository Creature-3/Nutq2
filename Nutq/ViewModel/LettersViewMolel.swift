//LettersViewModel
import Foundation
import Combine

class LettersViewModel: ObservableObject {
    @Published var searchText: String = ""

    private let allLetters = ArabicAlphabet.all

    // flat filtered list
    var filteredLetters: [Letter] {
        let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return allLetters }

        // you can search by symbol or name
        return allLetters.filter { letter in
            letter.symbol == text || letter.name.contains(text)
        }
    }

    // rows [[Letter]] for your grid:
    var filteredRows: [[Letter]] {
        let letters = filteredLetters
        let chunkSize = 2  // 2 letters per row like before

        var result: [[Letter]] = []
        var currentRow: [Letter] = []

        for (index, letter) in letters.enumerated() {
            currentRow.append(letter)
            if currentRow.count == chunkSize || index == letters.count - 1 {
                result.append(currentRow)
                currentRow = []
            }
        }
        return result
    }

    // 👇 alias so Library doesn’t break
    var filtered: [[Letter]] {
        filteredRows
    }
}
