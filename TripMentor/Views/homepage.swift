import SwiftUI

struct TripCategory: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
}

struct DestinationListing: Identifiable {
    let id = UUID()
    let name: String
    let country: String
    let rating: Double
    let reviews: Int
    let imageName: String
    let tag: String?
}

struct Homepage: View {
    @State private var searchText = ""
    @State private var showSettings = false
    @State private var selectedCategory = 0
    @AppStorage("isDarkModeEnabled") private var isDarkModeEnabled = false

    private let categories = [
        TripCategory(name: "Beaches", icon: "sun.max"),
        TripCategory(name: "Mountains", icon: "mountain.2"),
        TripCategory(name: "Cities", icon: "building.2"),
        TripCategory(name: "Islands", icon: "leaf"),
        TripCategory(name: "Historic", icon: "building.columns"),
        TripCategory(name: "Adventure", icon: "figure.hiking"),
    ]

    private let listings = [
        DestinationListing(name: "Ubud, Bali", country: "Indonesia", rating: 4.97, reviews: 248, imageName: "5", tag: "Guest favorite"),
        DestinationListing(name: "Santorini", country: "Greece", rating: 4.92, reviews: 193, imageName: "3", tag: nil),
        DestinationListing(name: "Interlaken", country: "Switzerland", rating: 4.99, reviews: 312, imageName: "4", tag: "Guest favorite"),
        DestinationListing(name: "Kyoto", country: "Japan", rating: 4.88, reviews: 174, imageName: "1", tag: nil),
        DestinationListing(name: "Tulum", country: "Mexico", rating: 4.85, reviews: 156, imageName: "2", tag: nil),
    ]

    var body: some View {
        VStack(spacing: 0) {
            headerBar
            categoryBar
            listingsScroll
        }
        .background(Color(.systemBackground))
        .sheet(isPresented: $showSettings) {
            NavigationStack {
                SettingsView(isDarkModeEnabled: $isDarkModeEnabled)
                    .navigationTitle("Settings")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Done") { showSettings = false }
                                .foregroundColor(Color("BrandTeal"))
                        }
                    }
            }
        }
    }

    private var headerBar: some View {
        HStack(spacing: 12) {
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color("BrandDarkTeal"))

                VStack(alignment: .leading, spacing: 2) {
                    if searchText.isEmpty {
                        Text("Where to?")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("BrandDarkTeal"))
                        Text("Anywhere · Any week · Any guests")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    } else {
                        TextField("Search destinations", text: $searchText)
                            .font(.subheadline)
                    }
                }

                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(.systemBackground))
            .cornerRadius(28)
            .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 2)
            .overlay(
                RoundedRectangle(cornerRadius: 28)
                    .stroke(Color.gray.opacity(0.15), lineWidth: 1)
            )
            .onTapGesture {
                searchText = " "
            }

            Button {
                showSettings = true
            } label: {
                Image(systemName: "gearshape")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color("BrandDarkTeal"))
                    .frame(width: 40, height: 40)
                    .background(Color(.systemBackground))
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }

    private var categoryBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 24) {
                ForEach(Array(categories.enumerated()), id: \.element.id) { index, category in
                    CategoryTab(
                        name: category.name,
                        icon: category.icon,
                        isSelected: selectedCategory == index
                    ) {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selectedCategory = index
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .padding(.vertical, 12)
        .overlay(alignment: .bottom) {
        Divider()
        }
    }

    private var listingsScroll: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 28) {
                ForEach(listings) { listing in
                    DestinationListingCard(listing: listing)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 100)
        }
    }
}

// MARK: - Category Tab

struct CategoryTab: View {
    let name: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(isSelected ? Color("BrandDarkTeal") : .gray)

                Text(name)
                    .font(.caption)
                    .fontWeight(isSelected ? .semibold : .regular)
                    .foregroundColor(isSelected ? Color("BrandDarkTeal") : .gray)
            }
            .frame(minWidth: 48)
            .overlay(alignment: .bottom) {
                if isSelected {
                    Rectangle()
                        .fill(Color("BrandDarkTeal"))
                        .frame(height: 2)
                        .offset(y: 12)
                }
            }
        }
    }
}

// MARK: - Listing Card

struct DestinationListingCard: View {
    let listing: DestinationListing

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            GeometryReader { geo in
                ZStack(alignment: .topLeading) {
                    Image(listing.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geo.size.width, height: 300)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 16))

                    HStack {
                        if let tag = listing.tag {
                            Text(tag)
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(Color("BrandDarkTeal"))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(.ultraThinMaterial)
                                .cornerRadius(20)
                        }

                        Spacer()

                        Image(systemName: "heart")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
                    }
                    .padding(14)
                }
            }
            .frame(height: 300)
            .clipShape(RoundedRectangle(cornerRadius: 16))

            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(listing.name), \(listing.country)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("BrandDarkTeal"))

                    Text("\(listing.reviews) reviews")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()

                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundColor(Color("BrandDarkTeal"))
                    Text(String(format: "%.2f", listing.rating))
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(Color("BrandDarkTeal"))
                }
            }
        }
    }
}

#Preview {
    Homepage()
}
