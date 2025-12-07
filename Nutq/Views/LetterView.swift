import Foundation

struct Letter: Identifiable, Equatable, Hashable {
    let id = UUID()
    let symbol: String      // "ب"
    let name: String        // "باء"
    let videoName: String   // "B3"   (without .mp4)

    var videoURL: URL? {
        Bundle.main.url(forResource: videoName, withExtension: "mp4")
    }
}


