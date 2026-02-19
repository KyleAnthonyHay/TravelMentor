import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @AppStorage("isDarkModeEnabled") private var isDarkModeEnabled = false

    var body: some View {
        TabView(selection: $selectedTab) {
            Homepage()
                .tag(0)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            FavoritesView()
                .tag(1)
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }

            MoreView()
                .tag(2)
                .tabItem {
                    Label("Itineraries", systemImage: "square.grid.2x2")
                }

            ChatView()
                .tag(3)
                .tabItem {
                    Label("Chat", systemImage: "sparkles")
                }
        }
        .preferredColorScheme(isDarkModeEnabled ? .dark : .light)
        .tint(Color("BrandTeal"))
        .toolbarBackground(Color.white, for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
    }
}

struct FavoritesView: View {
    private let favoriteDestinations = [
        FavoriteDestination(
            name: "Bali",
            country: "Indonesia",
            reviews: "248 reviews",
            imageName: "5",
            description: "A tropical paradise known for its forested volcanic mountains, iconic rice paddies, beaches, and coral reefs. Bali offers a perfect blend of adventure, culture, and relaxation.",
            highlights: [
                FavoriteHighlight(title: "Ubud Rice Terraces", subtitle: "Iconic stepped green paddies", imageName: "3"),
                FavoriteHighlight(title: "Uluwatu Temple", subtitle: "Cliffside temple with ocean views", imageName: "4"),
                FavoriteHighlight(title: "Seminyak Beach", subtitle: "Trendy beach clubs & sunsets", imageName: "1"),
                FavoriteHighlight(title: "Monkey Forest", subtitle: "Sacred sanctuary in Ubud", imageName: "2"),
            ]
        ),
        FavoriteDestination(
            name: "Santorini",
            country: "Greece",
            reviews: "193 reviews",
            imageName: "3",
            description: "Famous for its dramatic views, stunning sunsets, white-washed houses, and its very own active volcano. Santorini is one of the most romantic destinations in the world.",
            highlights: [
                FavoriteHighlight(title: "Oia Sunset", subtitle: "World-famous caldera sunset", imageName: "2"),
                FavoriteHighlight(title: "Red Beach", subtitle: "Unique volcanic red cliffs", imageName: "1"),
                FavoriteHighlight(title: "Fira Town", subtitle: "Cliffside capital with nightlife", imageName: "5"),
            ]
        ),
        FavoriteDestination(
            name: "Swiss Alps",
            country: "Switzerland",
            reviews: "312 reviews",
            imageName: "4",
            description: "Majestic peaks, crystal-clear lakes, and charming villages. The Swiss Alps are a year-round destination for hiking, skiing, and some of the most breathtaking scenery on Earth.",
            highlights: [
                FavoriteHighlight(title: "Jungfraujoch", subtitle: "Top of Europe at 3,454m", imageName: "4"),
                FavoriteHighlight(title: "Lake Brienz", subtitle: "Turquoise glacial lake", imageName: "2"),
                FavoriteHighlight(title: "Lauterbrunnen", subtitle: "Valley of 72 waterfalls", imageName: "3"),
                FavoriteHighlight(title: "Zermatt & Matterhorn", subtitle: "Iconic alpine peak", imageName: "5"),
            ]
        )
    ]

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Favorites")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(Color("BrandDarkTeal"))

                    Text("Saved destinations")
                        .foregroundColor(.secondary)

                    ForEach(favoriteDestinations) { destination in
                        NavigationLink(value: destination) {
                            FavoriteDestinationCard(destination: destination)
                        }
                        .buttonStyle(.plain)
                    }

                    Spacer(minLength: 100)
                }
                .padding(.horizontal, 28)
                .padding(.top, 8)
            }
            .background(Color(.systemGroupedBackground))
            .navigationDestination(for: FavoriteDestination.self) { destination in
                FavoriteDetailView(destination: destination)
            }
        }
    }
}

struct MoreView: View {
    private let itineraries = [
        TripItinerary(
            title: "Tokyo Explorer",
            destination: "Tokyo, Japan",
            dateRange: "Apr 12 - Apr 18",
            days: 7,
            imageName: "1",
            highlights: ["Shibuya Crossing", "TeamLab Planets", "Asakusa Temple"],
            timeline: [
                TimelineDay(dayLabel: "Day 1", date: "Apr 12", title: "Shibuya & Harajuku", description: "Kick off in the heart of Tokyo — walk the iconic Shibuya Crossing, explore Takeshita Street's wild fashion scene, and unwind at Meiji Shrine.", imageName: "1", stops: [
                    TimelineStop(name: "Shibuya Crossing", detail: "World's busiest intersection", imageName: "2"),
                    TimelineStop(name: "Meiji Shrine", detail: "Peaceful forest shrine", imageName: "3"),
                ]),
                TimelineDay(dayLabel: "Day 2", date: "Apr 13", title: "Asakusa & Akihabara", description: "Step back in time at Tokyo's oldest temple, sample street food on Nakamise-dori, then dive into Akihabara's electric anime culture.", imageName: "2", stops: [
                    TimelineStop(name: "Senso-ji Temple", detail: "Tokyo's oldest Buddhist temple", imageName: "4"),
                    TimelineStop(name: "Akihabara", detail: "Anime & electronics district", imageName: "5"),
                ]),
                TimelineDay(dayLabel: "Day 3", date: "Apr 14", title: "TeamLab & Odaiba", description: "Get lost in immersive digital art at TeamLab Planets, then catch sunset over Tokyo Bay from the Odaiba seaside.", imageName: "3", stops: [
                    TimelineStop(name: "TeamLab Planets", detail: "Interactive digital art museum", imageName: "1"),
                    TimelineStop(name: "Odaiba", detail: "Waterfront entertainment district", imageName: "2"),
                ]),
                TimelineDay(dayLabel: "Day 4", date: "Apr 15", title: "Day Trip — Mt. Fuji", description: "Take the bullet train to Hakone for a lake cruise with stunning views of Japan's iconic mountain.", imageName: "4", stops: [
                    TimelineStop(name: "Lake Ashi Cruise", detail: "Scenic pirate-ship cruise", imageName: "3"),
                    TimelineStop(name: "Hakone Ropeway", detail: "Aerial views of Owakudani valley", imageName: "4"),
                ]),
                TimelineDay(dayLabel: "Day 5", date: "Apr 16", title: "Shinjuku & Ginza", description: "Morning zen at Shinjuku Gyoen gardens, afternoon luxury shopping in Ginza, farewell dinner at a Roppongi rooftop.", imageName: "5", stops: [
                    TimelineStop(name: "Shinjuku Gyoen", detail: "Expansive national garden", imageName: "5"),
                    TimelineStop(name: "Ginza District", detail: "Upscale shopping & dining", imageName: "1"),
                ]),
            ]
        ),
        TripItinerary(
            title: "Bali Getaway",
            destination: "Bali, Indonesia",
            dateRange: "May 2 - May 8",
            days: 7,
            imageName: "5",
            highlights: ["Ubud Rice Terraces", "Uluwatu Temple", "Nusa Dua Beach"],
            timeline: [
                TimelineDay(dayLabel: "Day 1", date: "May 2", title: "Arrival & Seminyak", description: "Settle into your villa, explore Seminyak's beach clubs, and catch a legendary Bali sunset.", imageName: "5", stops: [
                    TimelineStop(name: "Seminyak Beach", detail: "Trendy beach & sunset spot", imageName: "1"),
                ]),
                TimelineDay(dayLabel: "Day 2", date: "May 3", title: "Ubud Rice Terraces", description: "Drive to Ubud and walk through the stunning Tegallalang rice terraces, visit the monkey forest.", imageName: "3", stops: [
                    TimelineStop(name: "Tegallalang", detail: "Iconic stepped rice paddies", imageName: "2"),
                    TimelineStop(name: "Monkey Forest", detail: "Sacred sanctuary in Ubud", imageName: "3"),
                ]),
                TimelineDay(dayLabel: "Day 3", date: "May 4", title: "Uluwatu Temple", description: "Visit the clifftop temple at golden hour and watch the traditional Kecak fire dance at sunset.", imageName: "4", stops: [
                    TimelineStop(name: "Uluwatu Temple", detail: "Cliffside sea temple", imageName: "4"),
                ]),
            ]
        ),
        TripItinerary(
            title: "Swiss Adventure",
            destination: "Interlaken, Switzerland",
            dateRange: "Jun 10 - Jun 16",
            days: 7,
            imageName: "4",
            highlights: ["Jungfrau Day Trip", "Lake Brienz Cruise", "Harder Kulm"],
            timeline: [
                TimelineDay(dayLabel: "Day 1", date: "Jun 10", title: "Arrive in Interlaken", description: "Settle in and take an evening stroll between Lake Thun and Lake Brienz with alpine views in every direction.", imageName: "4", stops: [
                    TimelineStop(name: "Höheweg Promenade", detail: "Main boulevard with Jungfrau views", imageName: "3"),
                ]),
                TimelineDay(dayLabel: "Day 2", date: "Jun 11", title: "Jungfraujoch", description: "Train to the 'Top of Europe' — glaciers, ice palace, and panoramic views from 3,454m.", imageName: "3", stops: [
                    TimelineStop(name: "Jungfraujoch", detail: "Highest railway station in Europe", imageName: "4"),
                    TimelineStop(name: "Eiger Trail", detail: "Dramatic alpine hiking path", imageName: "5"),
                ]),
                TimelineDay(dayLabel: "Day 3", date: "Jun 12", title: "Lake Brienz Cruise", description: "Cruise the turquoise waters of Lake Brienz and visit the charming village of Brienz and Giessbach Falls.", imageName: "2", stops: [
                    TimelineStop(name: "Lake Brienz", detail: "Crystal-clear glacial lake", imageName: "2"),
                    TimelineStop(name: "Giessbach Falls", detail: "14-stage cascading waterfall", imageName: "1"),
                ]),
            ]
        )
    ]

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Itineraries")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(Color("BrandDarkTeal"))

                    Text("Your itineraries")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("BrandDarkTeal"))

                    ForEach(itineraries) { itinerary in
                        NavigationLink(value: itinerary) {
                            ItineraryCardView(itinerary: itinerary)
                        }
                        .buttonStyle(.plain)
                    }

                    Spacer(minLength: 120)
                }
                .padding(.horizontal, 28)
                .padding(.top, 8)
            }
            .background(Color(.systemBackground))
            .navigationDestination(for: TripItinerary.self) { itinerary in
                ItineraryDetailView(itinerary: itinerary)
            }
        }
    }
}

struct SettingsView: View {
    @Binding var isDarkModeEnabled: Bool

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                Text("Settings")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(Color("BrandDarkTeal"))

                profileSection
                statsSection
                quickOptions

                Spacer(minLength: 100)
            }
            .padding(.horizontal, 28)
            .padding(.top, 8)
        }
        .background(Color(.systemBackground))
    }

    private var profileSection: some View {
        HStack(spacing: 14) {
            Image("profile-picture")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 64, height: 64)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text("Kyle Hay")
                    .font(.headline)
                    .foregroundColor(Color("BrandDarkTeal"))

                Text("TripMentor Explorer")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .padding(16)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color("BrandTeal").opacity(0.2), lineWidth: 1)
        )
        .cornerRadius(16)
    }

    private var statsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Travel data")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(Color("BrandDarkTeal"))

            HStack(spacing: 10) {
                SettingsStatCard(title: "12", subtitle: "Trips")
                SettingsStatCard(title: "7", subtitle: "Countries")
                SettingsStatCard(title: "34", subtitle: "Saved places")
            }
        }
    }

    private var quickOptions: some View {
        VStack(spacing: 10) {
            DarkModeToggleRow(isOn: $isDarkModeEnabled)
            SettingsOptionRow(icon: "bell", title: "Notifications")
            SettingsOptionRow(icon: "lock", title: "Privacy")
            SettingsOptionRow(icon: "questionmark.circle", title: "Help & Support")
        }
    }
}

struct DarkModeToggleRow: View {
    @Binding var isOn: Bool

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "moon.fill")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(Color("BrandTeal"))
                .frame(width: 28)

            Text("Dark mode")
                .foregroundColor(Color("BrandDarkTeal"))

            Spacer()

            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(Color("BrandTeal"))
        }
        .padding(14)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color("BrandTeal").opacity(0.15), lineWidth: 1)
        )
        .cornerRadius(12)
    }
}

struct SettingsStatCard: View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack(spacing: 6) {
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color("BrandDarkTeal"))

            Text(subtitle)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(Color("BrandTeal").opacity(0.12))
        .cornerRadius(12)
    }
}

struct SettingsOptionRow: View {
    let icon: String
    let title: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(Color("BrandTeal"))
                .frame(width: 28)

            Text(title)
                .foregroundColor(Color("BrandDarkTeal"))

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(14)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color("BrandTeal").opacity(0.15), lineWidth: 1)
        )
        .cornerRadius(12)
    }
}

struct FavoriteHighlight: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let subtitle: String
    let imageName: String
}

struct FavoriteDestination: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let country: String
    let reviews: String
    let imageName: String
    let description: String
    let highlights: [FavoriteHighlight]
}

struct FavoriteDestinationCard: View {
    let destination: FavoriteDestination

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(destination.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
            .frame(height: 220)
            .clipShape(RoundedRectangle(cornerRadius: 20))

            LinearGradient(
                colors: [.clear, .black.opacity(0.55)],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 220)
            .clipShape(RoundedRectangle(cornerRadius: 20))

            VStack(alignment: .leading, spacing: 8) {
                Text(destination.name)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                HStack(spacing: 8) {
                    Text(destination.country)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 5)
                        .background(Color("BrandTeal"))
                        .foregroundColor(.white)
                        .cornerRadius(8)

                    Text(destination.reviews)
                        .font(.caption)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 5)
                        .background(Color("BrandTeal").opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding(16)
        }
    }
}

struct FavoriteDetailView: View {
    let destination: FavoriteDestination

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                heroSection
                infoBar
                descriptionSection
                highlightsTimeline
                Spacer(minLength: 120)
            }
        }
        .background(Color(.systemBackground))
        .navigationTitle(destination.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var heroSection: some View {
        ZStack(alignment: .bottomLeading) {
            Image(destination.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 280)
                .clipped()

            LinearGradient(
                colors: [.clear, .black.opacity(0.6)],
                startPoint: .center,
                endPoint: .bottom
            )
            .frame(height: 280)

            VStack(alignment: .leading, spacing: 6) {
                Text(destination.name)
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.white)

                HStack(spacing: 8) {
                    Text(destination.country)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 5)
                        .background(Color("BrandTeal"))
                        .foregroundColor(.white)
                        .cornerRadius(8)

                    Text(destination.reviews)
                        .font(.caption)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 5)
                        .background(.white.opacity(0.25))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding(24)
        }
    }

    private var infoBar: some View {
        HStack {
            StatPill(icon: "heart.fill", text: "Saved")
            Spacer()
            StatPill(icon: "star.fill", text: destination.reviews)
            Spacer()
            StatPill(icon: "mappin.and.ellipse", text: "\(destination.highlights.count) spots")
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        .background(Color("BrandTeal").opacity(0.08))
    }

    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("About")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color("BrandDarkTeal"))

            Text(destination.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal, 28)
        .padding(.top, 24)
        .padding(.bottom, 8)
    }

    private var highlightsTimeline: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Highlights")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color("BrandDarkTeal"))
                .padding(.horizontal, 28)
                .padding(.top, 16)
                .padding(.bottom, 16)

            ForEach(Array(destination.highlights.enumerated()), id: \.element.id) { index, highlight in
                FavoriteTimelineRow(
                    highlight: highlight,
                    index: index,
                    isLast: index == destination.highlights.count - 1
                )
            }
        }
    }
}

struct FavoriteTimelineRow: View {
    let highlight: FavoriteHighlight
    let index: Int
    let isLast: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            // Timeline track
            VStack(spacing: 0) {
                Circle()
                    .fill(Color("BrandTeal"))
                    .frame(width: 14, height: 14)
                    .overlay(
                        Circle()
                            .fill(Color.white)
                            .frame(width: 6, height: 6)
                    )

                if !isLast {
                    Rectangle()
                        .fill(Color("BrandTeal").opacity(0.3))
                        .frame(width: 2)
                }
            }
            .frame(width: 56)

            // Content
            VStack(alignment: .leading, spacing: 10) {
                Text(highlight.title)
                    .font(.headline)
                    .foregroundColor(Color("BrandDarkTeal"))

                Image(highlight.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 140)
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 14))

                Text(highlight.subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                if !isLast {
                    Divider()
                        .padding(.top, 4)
                        .padding(.bottom, 16)
                } else {
                    Spacer().frame(height: 16)
                }
            }
            .padding(.trailing, 24)
        }
    }
}

struct TimelineStop: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let detail: String
    let imageName: String
}

struct TimelineDay: Identifiable, Hashable {
    let id = UUID()
    let dayLabel: String
    let date: String
    let title: String
    let description: String
    let imageName: String
    let stops: [TimelineStop]
}

struct TripItinerary: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let destination: String
    let dateRange: String
    let days: Int
    let imageName: String
    let highlights: [String]
    let timeline: [TimelineDay]
}

struct ItineraryCardView: View {
    let itinerary: TripItinerary

    var body: some View {
        HStack(spacing: 14) {
            Image(itinerary.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 96, height: 96)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 6) {
                Text(itinerary.title)
                    .font(.headline)
                    .foregroundColor(Color("BrandDarkTeal"))

                Text(itinerary.destination)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                HStack(spacing: 8) {
                    Text(itinerary.dateRange)
                        .font(.caption)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color("BrandTeal").opacity(0.15))
                        .foregroundColor(Color("BrandDarkTeal"))
                        .cornerRadius(8)

                    Text("\(itinerary.days) days")
                        .font(.caption)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color("BrandTeal").opacity(0.15))
                        .foregroundColor(Color("BrandDarkTeal"))
                        .cornerRadius(8)
                }
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(Color("BrandTeal"))
        }
        .padding(14)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color("BrandTeal").opacity(0.2), lineWidth: 1)
        )
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.04), radius: 4, x: 0, y: 2)
    }
}

struct ItineraryDetailView: View {
    let itinerary: TripItinerary

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                heroSection
                statsBar
                timelineSection
                Spacer(minLength: 120)
            }
        }
        .background(Color(.systemBackground))
        .navigationTitle("Itinerary")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var heroSection: some View {
        ZStack(alignment: .bottomLeading) {
            Image(itinerary.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 260)
                .clipped()

            LinearGradient(
                colors: [.clear, .black.opacity(0.6)],
                startPoint: .center,
                endPoint: .bottom
            )
            .frame(height: 260)

            VStack(alignment: .leading, spacing: 6) {
                Text(itinerary.title)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)

                Text(itinerary.destination)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.85))
            }
            .padding(24)
        }
    }

    private var statsBar: some View {
        HStack(spacing: 0) {
            StatPill(icon: "calendar", text: itinerary.dateRange)
            Spacer()
            StatPill(icon: "clock", text: "\(itinerary.days) days")
            Spacer()
            StatPill(icon: "mappin.and.ellipse", text: "\(itinerary.timeline.reduce(0) { $0 + $1.stops.count }) stops")
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        .background(Color("BrandTeal").opacity(0.08))
    }

    private var timelineSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Timeline")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color("BrandDarkTeal"))
                .padding(.horizontal, 28)
                .padding(.top, 24)
                .padding(.bottom, 16)

            ForEach(Array(itinerary.timeline.enumerated()), id: \.element.id) { index, day in
                TimelineRow(day: day, isLast: index == itinerary.timeline.count - 1)
            }
        }
    }
}

// MARK: - Stat Pill

struct StatPill: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(Color("BrandTeal"))
            Text(text)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(Color("BrandDarkTeal"))
        }
    }
}

// MARK: - Timeline Row

struct TimelineRow: View {
    let day: TimelineDay
    let isLast: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            timelineTrack
            dayContent
        }
        .padding(.trailing, 24)
    }

    private var timelineTrack: some View {
        VStack(spacing: 0) {
            Circle()
                .fill(Color("BrandTeal"))
                .frame(width: 14, height: 14)
                .overlay(
                    Circle()
                        .fill(Color.white)
                        .frame(width: 6, height: 6)
                )

            if !isLast {
                Rectangle()
                    .fill(Color("BrandTeal").opacity(0.3))
                    .frame(width: 2)
            }
        }
        .frame(width: 56)
    }

    private var dayContent: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .firstTextBaseline) {
                Text(day.dayLabel)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color("BrandTeal"))

                Text(day.date)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Text(day.title)
                .font(.headline)
                .foregroundColor(Color("BrandDarkTeal"))

            Image(day.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 160)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 14))

            Text(day.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(day.stops) { stop in
                        TimelineStopCard(stop: stop)
                    }
                }
            }

            if !isLast {
                Divider()
                    .padding(.top, 8)
                    .padding(.bottom, 16)
            } else {
                Spacer().frame(height: 16)
            }
        }
    }
}

// MARK: - Timeline Stop Card

struct TimelineStopCard: View {
    let stop: TimelineStop

    var body: some View {
        HStack(spacing: 10) {
            Image(stop.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 48, height: 48)
                .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading, spacing: 2) {
                Text(stop.name)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("BrandDarkTeal"))
                    .lineLimit(1)

                Text(stop.detail)
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
        }
        .padding(8)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color("BrandTeal").opacity(0.2), lineWidth: 1)
        )
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.04), radius: 3, x: 0, y: 1)
    }
}

#Preview {
    ContentView()
}
