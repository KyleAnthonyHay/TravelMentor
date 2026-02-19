import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Int

    var body: some View {
        HStack {
            Spacer()
            tabBarItem(icon: "house.fill", index: 0)
            Spacer()
            tabBarItem(icon: "building.2.fill", index: 1)
            Spacer()
            tabBarItem(icon: "magnifyingglass", index: 2)
            Spacer()
            tabBarItem(icon: "heart", index: 3)
            Spacer()
            tabBarItem(icon: "square.grid.2x2", index: 4)
            Spacer()
        }
        .padding(.vertical, 14)
        .background(
            Color("BrandDarkTeal")
                .clipShape(RoundedRectangle(cornerRadius: 28))
                .shadow(color: .black.opacity(0.2), radius: 12, x: 0, y: -4)
        )
        .padding(.horizontal, 28)
        .padding(.bottom, 4)
    }

    private func tabBarItem(icon: String, index: Int) -> some View {
        Button {
            selectedTab = index
        } label: {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(selectedTab == index ? .white : .white.opacity(0.5))
                .frame(width: 44, height: 44)
                .contentShape(Rectangle())
        }
    }
}
