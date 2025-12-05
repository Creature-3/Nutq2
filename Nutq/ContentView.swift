import SwiftUI

struct ContentView: View {
    @State private var showSplash = true   // 👈 نبدأ بالسلاش

    var body: some View {
        NavigationStack {
            Group {
                if showSplash {
                    SplashView()
                        .onAppear {
                            // بعد 2.5 ثانية ننتقل تلقائياً للمكتبة
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                 withAnimation(.easeInOut) {
                                    showSplash = false
                                }
                            }
                        }
                } else {
                    Library()   // 👈 شاشتك الحالية بدون أي تغيير في التصميم
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

