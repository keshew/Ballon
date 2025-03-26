import SwiftUI

extension Text {
    func Plus(size: CGFloat,
                 color: Color = .white) -> some View {
        self.font(.custom("PlusJakartaSans-Regular", size: size))
            .foregroundColor(color)
    }
    
    func PlusBold(size: CGFloat,
                 color: Color = .white) -> some View {
        self.font(.custom("PlusJakartaSans-Bold", size: size))
            .foregroundColor(color)
    }
}
