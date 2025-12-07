// FeedBackView
//Views
import SwiftUI
import AVKit

struct ListeningView: View {
    @Environment(\.dismiss) private var dismiss
    let letter: Letter

    var body: some View {
        ZStack {
            Color.color2
                .ignoresSafeArea()

            VStack {
                CircleVideoSection(videoURL: letter.videoURL)
                    .padding(.top, 200)

                Spacer()
            }
            .navigationBarBackButtonHidden(true)

            VStack {
                HStack {
                    backButton
                        .padding(.leading, 20)
                        .padding(.top, 35)
                        .onTapGesture {
                            dismiss()
                        }
                    Spacer()
                }
                Spacer()
            }

            VStack {
                Spacer()
                HStack {
                    micButton
                        .padding(.leading, 30)
                        .padding(.bottom, 40)
                    Spacer()
                }
            }
        }
    }
}

struct CircleVideoSection: View {
    let videoURL: URL?
    @State private var animate = false

    var body: some View {
        ZStack {
            Ellipse()
                .fill(Color("LightColor"))
                .frame(width: animate ? 390 : 380, height: animate ? 350 : 340)
                .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: animate)

            Ellipse()
                .fill(Color("MidColor"))
                .frame(width: animate ? 350 : 340, height: animate ? 330 : 320)
                .animation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true), value: animate)

            Ellipse()
                .fill(Color("DarkColor"))
                .frame(width: animate ? 310 : 300, height: animate ? 300 : 290)
                .animation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true), value: animate)

            CircleVideoView(videoURL: videoURL)
                .frame(width: 340, height: 260)
                .clipShape(Circle())
        }
        .onAppear {
            animate = true
        }
    }
}

struct CircleVideoView: View {
    let videoURL: URL?
    @State private var player: AVPlayer?

    var body: some View {
        Group {
            if let url = videoURL {
                VideoPlayer(player: player)
                    .aspectRatio(contentMode: .fill)
                    .onAppear {
                        if player == nil {
                            player = AVPlayer(url: url)
                        }
                        player?.play()
                    }
                    .onDisappear {
                        player?.pause()
                    }
            } else {
                // fallback if no video found
                Color.black.opacity(0.2)
            }
        }
    }
}

var micButton: some View {
    ZStack {
        Image(systemName: "mic.fill")
            .font(.system(size: 40))
            .foregroundColor(Color.gray.opacity(0.45))
            .offset(x: -3, y: -3)

        Image(systemName: "mic.fill")
            .font(.system(size: 40))
            .foregroundColor(.black)
    }
    .offset(x: 150, y: 20)
}

var backButton: some View {
    ZStack {
        Circle()
            .fill(Color.black)
            .frame(width: 46, height: 47)

        Image(systemName: "chevron.left")
            .font(.system(size: 22, weight: .bold))
            .foregroundColor(Color("LightColor"))
    }
    .frame(width: 60, height: 65)
    .offset(y: -50)
}

struct ListeningView_Previews: PreviewProvider {
    static var previews: some View {
        ListeningView(
            letter: Letter(
                symbol: "أ",
                name: "ألف",
                videoName: "A"
            )
        )
    }
}
