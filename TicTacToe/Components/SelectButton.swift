import SwiftUI

struct SelectButton: View {
    var imageName: String?
    var buttonText: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                if let imageName = imageName {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 38, height: 29)
                }
                
                Text(buttonText)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.customBlack)
                
                //Spacer() // Добавляем Spacer для адаптивности
            }
            .padding() // Обеспечиваем отступы внутри кнопки
            .frame(maxWidth: .infinity, minHeight: 60) // Максимальная ширина и минимальная высота
            .background(Color.customLightBlue)
            .cornerRadius(30)
        }
        .buttonStyle(PlainButtonStyle()) // Убираем стиль кнопки по умолчанию
        .padding(.horizontal, 20)
        .padding(.vertical, 5)
    }
}

#Preview {
    SelectButton(imageName: "singlePlayer", buttonText: "Single Player") {
        print("Button tapped")
    }
    
    SelectButton(buttonText: "No Image Button") {
        print("No image button tapped")
    }
}
