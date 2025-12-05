import Foundation

struct Letter: Identifiable, Hashable {
    let id = UUID()
    let value: String
    let videoURL: URL
}

