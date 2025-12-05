import SwiftUI

struct Library: View {
    
    @StateObject private var viewModel = LettersViewModel()
    
    var body: some View {
        ZStack {
            Image("Image 3")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                Spacer().frame(height: 38)
                
                // عنوان الصفحة
                Text("اختر الحرف")
                    .font(.system(size: 36, weight:.bold))
                    .foregroundColor(Color("Color 3"))
                
                // شبكة الحروف مع Scroll
                ScrollView {
                    VStack(spacing: 46) {
                        ForEach(viewModel.filtered, id: \.self) { row in
                            HStack(spacing: 18) {
                                ForEach(row) { letter in
                                    NavigationLink(destination: ListeningView(letter: letter)) {  // 👈 نرسل الحرف هنا
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 20)
                                                .foregroundColor(Color("Color"))
                                                .frame(width: 177, height: 70)
                                                .offset(y: 42)
                                                .position(x: 88, y: 48)
                                            
                                            RoundedRectangle(cornerRadius: 25)
                                                .foregroundColor(Color("LightColor"))
                                                .frame(width: 177, height: 100)
                                            Spacer().frame(width: 10)
                                            
                                            Text(letter.value)
                                                .font(.system(size: 40, weight: .bold))
                                                .foregroundColor(Color("Color 3"))
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                    .frame(maxHeight: 150 * 150)
                }
                .padding(.bottom, 30)
                
                // مربع البحث
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black)
                    
                    TextField("ابحث عن الحرف", text: $viewModel.searchText)
                        .font(.system(size: 22))
                        .multilineTextAlignment(.trailing)
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.5), radius: 6, y: 2)
                .padding(.horizontal, 20)
                .padding(.bottom, 60)
            }
            .padding(.top, 30)
        }
    }
}

#Preview {
    Library()
}
