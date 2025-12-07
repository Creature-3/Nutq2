//LettersViewModel
import SwiftUI
import Combine

class LettersViewModel: ObservableObject {
    @Published var searchText: String = ""
    
    
    let letters: [[Letter]] = [
        [
            
            Letter(
                value: "أ",
                videoURL: Bundle.main.url(forResource: "A", withExtension: "mp4")!
            ),
            
            Letter(
                value: "ب",
                videoURL: Bundle.main.url(forResource: "B3", withExtension: "mp4")!
            )
        ],
        [
            
            Letter(
                value: "ت",
                videoURL: Bundle.main.url(forResource: "T", withExtension: "mp4")!
            ),
            
            Letter(
                value: "ث",
                videoURL: Bundle.main.url(forResource: "A", withExtension: "mp4")!
            )
        ],
        [
            Letter(
                value: "ج",
                videoURL: Bundle.main.url(forResource: "A", withExtension: "mp4")!
            ),
            Letter(
                value: "ح",
                videoURL: Bundle.main.url(forResource: "A", withExtension: "mp4")!
            )
        ],
        [
            Letter(
                value: "خ",
                videoURL: Bundle.main.url(forResource: "A", withExtension: "mp4")!
            ),
            Letter(
                value: "د",
                videoURL: Bundle.main.url(forResource: "A", withExtension: "mp4")!
            )
        ],
        [
            Letter(
                value: "ذ",
                videoURL: Bundle.main.url(forResource: "A", withExtension: "mp4")!
            ),
            Letter(
                value: "ر",
                videoURL: Bundle.main.url(forResource: "A", withExtension: "mp4")!
            )
        ],
        [
            Letter(
                value: "ز",
                videoURL: Bundle.main.url(forResource: "A", withExtension: "mp4")!
            ),
            Letter(
                value: "س",
                videoURL: Bundle.main.url(forResource: "A", withExtension: "mp4")!
            )
        ],
        [
            Letter(
                value: "ش",
                videoURL: Bundle.main.url(forResource: "A", withExtension: "mp4")!
            ),
            Letter(
                value: "ص",
                videoURL: Bundle.main.url(forResource: "A", withExtension: "mp4")!
            )
        ],
        [
            Letter(
                value: "ض",
                videoURL: Bundle.main.url(forResource: "A", withExtension: "mp4")!
            ),
            Letter(
                value: "ط",
                videoURL: Bundle.main.url(forResource: "A", withExtension: "mp4")!
            )
        ],
        [
            Letter(
                value: "ظ",
                videoURL: Bundle.main.url(forResource: "A", withExtension: "mp4")!
            ),
            Letter(
                value: "ع",
                videoURL: Bundle.main.url(forResource: "A", withExtension: "mp4")!
            )
        ],
        [
            Letter(
                value: "غ",
                videoURL: Bundle.main.url(forResource: "A", withExtension: "mp4")!
            ),
            Letter(
                value: "ف",
                videoURL: Bundle.main.url(forResource: "A", withExtension: "mp4")!
            )
        ],
        [
            Letter(
                value: "ق",
                videoURL: Bundle.main.url(forResource: "A", withExtension: "mp4")!
            ),
            Letter(
                value: "ك",
                videoURL: Bundle.main.url(forResource: "A", withExtension: "mp4")!
            )
        ],
        [
            Letter(
                value: "ل",
                videoURL: Bundle.main.url(forResource: "A", withExtension: "mp4")!
            ),
            Letter(
                value: "م",
                videoURL: Bundle.main.url(forResource: "A", withExtension: "mp4")!
            )
        ],
        [
            Letter(
                value: "ن",
                videoURL: Bundle.main.url(forResource: "A", withExtension: "mp4")!
            ),
            Letter(
                value: "هـ",
                videoURL: Bundle.main.url(forResource: "A", withExtension: "mp4")!
            )
        ],
        [
            Letter(
                value: "و",
                videoURL: Bundle.main.url(forResource: "A", withExtension: "mp4")!
            ),
            Letter(
                value: "ي",
                videoURL: Bundle.main.url(forResource: "A", withExtension: "mp4")!
            )
        ]
    ]
    
    // الفلترة حسب البحث
    var filtered: [[Letter]] {
        if searchText.isEmpty { return letters }
        
        let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return letters }
        
        // نحذف الحروف اللي ما تطابق البحث داخل كل صف
        let filteredRows = letters.map { row in
            row.filter { $0.value == text }   // بحث مطابق تمامًا للحرف
        }
        
        // نحذف الصفوف الفارغة
        return filteredRows.filter { !$0.isEmpty }
    }
}

