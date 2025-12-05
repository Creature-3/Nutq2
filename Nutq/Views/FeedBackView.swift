// FeedBackView
//Views
import SwiftUI
import AVKit   // ← required for playing video

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

            // 🔙 Back button overlay – top-left
            VStack {
                HStack {
                    backButton
                        .padding(.leading, 20)
                        .padding(.top, 35)
                        .onTapGesture {
                            dismiss()   // يرجع إلى Library
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
    let videoURL: URL              // 👈 يستقبل رابط الفيديو
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

            CircleVideoView(videoURL: videoURL)   // 👈 نمرر نفس الرابط
                .frame(width: 340, height: 260)
                .clipShape(Circle())
        }
        .onAppear {
            animate = true
        }
    }
}

struct CircleVideoView: View {
    let videoURL: URL              // 👈 يستقبل الرابط
    @State private var player: AVPlayer?   // نحتفظ بالـ player

    var body: some View {
        VideoPlayer(player: player)
            .aspectRatio(contentMode: .fill)  // نفس الشكل القديم
            .onAppear {
                if player == nil {
                    player = AVPlayer(url: videoURL)
                }
                player?.play()
            }
            .onDisappear {
                player?.pause()
            }
    }
}

//
// MARK: - زر المايك
//
var micButton: some View {
    ZStack {
        //Circle()
         //   .fill(Color("LightColor")) // Purple
          //  .frame(width: 50, height: 65)

        // Gray mic shadow
        Image(systemName: "mic.fill")
            .font(.system(size: 40))
            .foregroundColor(Color.gray.opacity(0.45))
            .offset(x: -3, y: -3)

        // Main black mic
        Image(systemName: "mic.fill")
            .font(.system(size: 40))
            .foregroundColor(.black)
    }
    .offset(x: 150, y: 20)
}

//
// MARK: - زر الرجوع
//
var backButton: some View {
    ZStack {
       // Circle()
        //    .fill(Color("LightColor")) // outer purple circle
        
        Circle()
            .fill(Color.black) // inner black circle
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
        // معاينة بسيطة بحرف واحد
        ListeningView(
            letter:Letter(
                    value: "أ",
                    videoURL: Bundle.main.url(forResource: "A", withExtension: "mp4")!
                
            )
        )
    }
}

