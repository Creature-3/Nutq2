import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            // خلفية بسيطة للسلاش (تقدرين تغيرينها لاحقًا)
            Color(.systemBackground)
                .ignoresSafeArea()

            // شعار التطبيق
            Image("AppLogo")        // 👈 استبدلي الاسم لو سميتيه شيء آخر
                .resizable()
                .scaledToFit()
                .frame(width: 260, height: 260)
        }
    }
}

#Preview {
    SplashView()
}


