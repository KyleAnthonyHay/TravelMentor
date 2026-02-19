import SwiftUI

struct SuggestTravelsView: View {
    private let recommendations = [
        RecommendationCard(
            title: "Ski/Surf",
            subtitle: "Adventure awaits",
            imageName: "1"
        ),
        RecommendationCard(
            title: "Vacation",
            subtitle: "Relax & unwind",
            imageName: "2"
        ),
        RecommendationCard(
            title: "Weekend Escape",
            subtitle: "Quick getaway",
            imageName: "3"
        ),
        RecommendationCard(
            title: "Relax",
            subtitle: "Peaceful retreat",
            imageName: "4"
        )
    ]

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                heroImageSection
                contentSection
                Spacer(minLength: 100)
            }
        }
        .background(Color(.systemBackground))
        .ignoresSafeArea(edges: .top)
    }

    

    // MARK: - Hero Image

    private var heroImageSection: some View {
        Image("mountains")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 280)
            .clipped()
            .overlay(
                LinearGradient(
                    colors: [.clear, Color(.systemBackground)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
    }

    // MARK: - Content Section

    private var contentSection: some View {
        VStack(alignment: .leading, spacing: 24) {
            recommendedSection

            Group {
                saveTripSection
                middleBanner
                buildTripButton
            }
            .padding(.horizontal, 28)
        }
        .padding(.top, 24)
        .background(Color(.systemBackground))
    }

    private var recommendedSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Recommended for your trip")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color("BrandDarkTeal"))
                .padding(.horizontal, 28)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(recommendations, id: \.title) { recommendation in
                        RecommendationCardView(card: recommendation)
                    }
                }
                .padding(.leading, 28)
            }
        }
    }

    private var saveTripSection: some View {
        HStack {
            Image(systemName: "person.crop.circle.badge.checkmark")
                .font(.system(size: 24))
                .foregroundColor(Color("BrandDarkTeal"))

            Text("Save your next trip")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(Color("BrandDarkTeal"))

            Spacer()

            Button(action: {}) {
                Text("Use 8%")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color("BrandTeal"))
                    .cornerRadius(12)
            }
        }
        .padding(16)
        .background(Color("BrandTeal").opacity(0.15))
        .cornerRadius(16)
    }

    private var middleBanner: some View {
        Image("mountains")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 180)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(Color("BrandTeal").opacity(0.3), lineWidth: 1)
            )
    }

    private var buildTripButton: some View {
        Button(action: {}) {
            HStack {
                Text("Build your own trip")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)

                Spacer()

                Image(systemName: "arrow.right")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 18)
            .background(Color("BrandDarkTeal"))
            .cornerRadius(16)
        }
    }
}

// MARK: - Recommendation Card Model

struct RecommendationCard {
    let title: String
    let subtitle: String
    let imageName: String
}

// MARK: - Recommendation Card View

struct RecommendationCardView: View {
    let card: RecommendationCard

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(card.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
            .frame(width: 140, height: 140)
            .clipShape(RoundedRectangle(cornerRadius: 16))

            VStack(alignment: .leading, spacing: 4) {
                Text(card.title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("BrandDarkTeal"))

                Text(card.subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .frame(width: 140)
    }
}

#Preview {
    SuggestTravelsView()
}
