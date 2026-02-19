import SwiftUI

// MARK: - Models

struct PlanStop: Identifiable {
    let id = UUID()
    let dayLabel: String
    let title: String
    let subtitle: String
    let imageName: String
}

enum ChatContent {
    case text(String)
    case plan(header: String, stops: [PlanStop], footer: String)
}

struct ChatMessage: Identifiable {
    let id = UUID()
    let content: ChatContent
    let isUser: Bool
    let timestamp: String?
}

// MARK: - Demo Data

private let demoPlan = ChatContent.plan(
    header: "Here's your 5-day Tokyo itinerary! I've curated the best experiences for each day:",
    stops: [
        PlanStop(dayLabel: "Day 1", title: "Shibuya & Harajuku", subtitle: "Explore Shibuya Crossing, Meiji Shrine, and Takeshita Street", imageName: "1"),
        PlanStop(dayLabel: "Day 2", title: "Asakusa & Akihabara", subtitle: "Visit Senso-ji Temple, Nakamise Street, then dive into anime culture", imageName: "2"),
        PlanStop(dayLabel: "Day 3", title: "TeamLab & Odaiba", subtitle: "Immersive digital art followed by seaside views and Gundam statue", imageName: "3"),
        PlanStop(dayLabel: "Day 4", title: "Day Trip – Mt. Fuji", subtitle: "Bullet train to Hakone, lake cruise with views of Fuji", imageName: "4"),
        PlanStop(dayLabel: "Day 5", title: "Shinjuku & Ginza", subtitle: "Shinjuku Gyoen gardens, shopping in Ginza, farewell dinner in Roppongi", imageName: "5"),
    ],
    footer: "Want me to adjust anything? I can swap days, add food recommendations, or find hotels near each area."
)

private let demoMessages: [ChatMessage] = [
    ChatMessage(
        content: .text("Hi there! I'm your TripMentor AI assistant. I'm excited to help you plan your next adventure!\n\nWhether you're looking for hidden gems, local favorites, or the best travel tips — I'm here to help. What destination are you dreaming about?"),
        isUser: false,
        timestamp: nil
    ),
    ChatMessage(
        content: .text("Hey! I'm thinking about visiting Tokyo next month. Any must-see spots you'd recommend?"),
        isUser: true,
        timestamp: nil
    ),
    ChatMessage(
        content: .text("Tokyo is an incredible choice! Here are some must-visit spots:\n\n• Shibuya Crossing – the world's busiest intersection\n• TeamLab Borderless – immersive digital art\n• Asakusa & Senso-ji – Tokyo's oldest temple\n• Shinjuku Gyoen – peaceful gardens\n\nWould you like me to build a full itinerary for you?"),
        isUser: false,
        timestamp: "Today at 9:04 AM"
    ),
    ChatMessage(
        content: .text("Yes please! I have 5 days. Build me something amazing 🙏"),
        isUser: true,
        timestamp: nil
    ),
    ChatMessage(
        content: demoPlan,
        isUser: false,
        timestamp: "Today at 9:06 AM"
    ),
]

// MARK: - ChatView

struct ChatView: View {
    @State private var messageText = ""
    @FocusState private var isInputFocused: Bool
    @State private var messages: [ChatMessage] = demoMessages

    var body: some View {
        ZStack {
            brandGradientBackground

            VStack(spacing: 0) {
                chatHeader
                scrollableMessages
                inputBar
            }
        }
    }

    private var brandGradientBackground: some View {
        LinearGradient(
            colors: [
                Color("BrandTeal").opacity(0.08),
                Color("BrandTeal").opacity(0.15),
                Color("BrandDarkTeal").opacity(0.12)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }

    private var chatHeader: some View {
        HStack {
            Image(systemName: "sparkles")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(Color("BrandTeal"))

            Text("TripMentor AI")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color("BrandDarkTeal"))

            Spacer()

            Menu {
                Button("Clear Chat", role: .destructive) {}
            } label: {
                Image(systemName: "ellipsis")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color("BrandDarkTeal"))
                    .frame(width: 36, height: 36)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
    }

    private var scrollableMessages: some View {
        ScrollViewReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 16) {
                    ForEach(messages) { message in
                        ChatBubble(message: message)
                            .id(message.id)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
            }
            .onChange(of: messages.count) {
                if let last = messages.last {
                    withAnimation {
                        proxy.scrollTo(last.id, anchor: .bottom)
                    }
                }
            }
        }
    }

    private var inputBar: some View {
        HStack(spacing: 12) {
            Button {} label: {
                Image(systemName: "plus")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color("BrandDarkTeal"))
                    .frame(width: 36, height: 36)
                    .background(Color("BrandTeal").opacity(0.12))
                    .clipShape(Circle())
            }

            HStack {
                TextField("Share with TripMentor...", text: $messageText)
                    .font(.body)
                    .focused($isInputFocused)

                if messageText.isEmpty {
                    Image(systemName: "waveform")
                        .foregroundColor(Color("BrandTeal"))
                } else {
                    Button {
                        sendMessage()
                    } label: {
                        Image(systemName: "arrow.up")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30)
                            .background(Color("BrandTeal"))
                            .clipShape(Circle())
                    }
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(Color.white.opacity(0.9))
            .cornerRadius(22)
            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(.ultraThinMaterial)
    }

    private func sendMessage() {
        guard !messageText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        messages.append(ChatMessage(content: .text(messageText), isUser: true, timestamp: nil))
        messageText = ""
    }
}

// MARK: - Chat Bubble

struct ChatBubble: View {
    let message: ChatMessage

    var body: some View {
        VStack(spacing: 6) {
            if let timestamp = message.timestamp {
                Text(timestamp)
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .padding(.top, 8)
            }

            switch message.content {
            case .text(let text):
                textBubble(text)
            case .plan(let header, let stops, let footer):
                planBubble(header: header, stops: stops, footer: footer)
            }
        }
    }

    private func textBubble(_ text: String) -> some View {
        HStack {
            if message.isUser { Spacer(minLength: 48) }

            Text(text)
                .font(.body)
                .foregroundColor(Color("BrandDarkTeal"))
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(
                    message.isUser
                        ? Color("BrandTeal").opacity(0.18)
                        : Color.white.opacity(0.85)
                )
                .cornerRadius(20)

            if !message.isUser { Spacer(minLength: 48) }
        }
    }

    private func planBubble(header: String, stops: [PlanStop], footer: String) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header text
            Text(header)
                .font(.body)
                .foregroundColor(Color("BrandDarkTeal"))
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 12)

            // Sparkle separator
            HStack(spacing: 6) {
                Rectangle()
                    .fill(Color("BrandTeal").opacity(0.25))
                    .frame(height: 1)
                Image(systemName: "sparkles")
                    .font(.system(size: 12))
                    .foregroundColor(Color("BrandTeal"))
                Text("Itinerary")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("BrandTeal"))
                Rectangle()
                    .fill(Color("BrandTeal").opacity(0.25))
                    .frame(height: 1)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 12)

            // Plan cards — horizontal scroll
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(stops) { stop in
                        PlanStopCard(stop: stop)
                    }
                }
                .padding(.horizontal, 16)
            }
            .padding(.bottom, 12)

            // Progress row
            HStack(spacing: 8) {
                ForEach(0..<5) { i in
                    Circle()
                        .fill(Color("BrandTeal").opacity(i < 5 ? 1 : 0.3))
                        .frame(width: 6, height: 6)
                }
                Spacer()
                Text("5 days planned")
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundColor(Color("BrandTeal"))
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 10)

            // Separator
            Rectangle()
                .fill(Color("BrandTeal").opacity(0.15))
                .frame(height: 1)
                .padding(.horizontal, 16)

            // Footer text
            Text(footer)
                .font(.callout)
                .foregroundColor(Color("BrandDarkTeal").opacity(0.8))
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
        }
        .background(Color.white.opacity(0.85))
        .cornerRadius(20)
    }
}

// MARK: - Plan Stop Card

struct PlanStopCard: View {
    let stop: PlanStop

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topLeading) {
                Image(stop.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 180, height: 110)
                    .clipped()

                Text(stop.dayLabel)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color("BrandDarkTeal").opacity(0.75))
                    .cornerRadius(6)
                    .padding(8)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(stop.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("BrandDarkTeal"))

                Text(stop.subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            .padding(10)
        }
        .frame(width: 180)
        .background(Color.white)
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.06), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    ChatView()
}
