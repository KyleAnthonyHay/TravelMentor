import SwiftUI
import MapKit

// MARK: - Model

struct GlobalTrip: Identifiable {
    let id = UUID()
    let employeeName: String
    let clientName: String
    let status: TripStatus
    let departureAirport: String
    let arrivalAirport: String
    let departureTime: String
    let arrivalTime: String
    let destinationCity: String
    let dateRange: String
    let estimatedCost: String
    let flightStatus: FlightStatus
    let latitude: Double
    let longitude: Double

    enum TripStatus: String {
        case planned = "Planned"
        case active = "Active"
        case completed = "Completed"

        var color: Color {
            switch self {
            case .planned: return .orange
            case .active: return Color("BrandTeal")
            case .completed: return .gray
            }
        }
    }

    enum FlightStatus: String {
        case onTime = "On Time"
        case delayed = "Delayed"
        case pending = "Pending"

        var color: Color {
            switch self {
            case .onTime: return .green
            case .delayed: return .orange
            case .pending: return .gray
            }
        }
    }
}

// MARK: - Sample Data

private let sampleTrips: [GlobalTrip] = [
    GlobalTrip(
        employeeName: "Marcus Johnson",
        clientName: "Acme Corp",
        status: .active,
        departureAirport: "ATL",
        arrivalAirport: "JFK",
        departureTime: "6:00 AM",
        arrivalTime: "8:45 AM",
        destinationCity: "New York",
        dateRange: "Feb 18 – Feb 25",
        estimatedCost: "$1,240",
        flightStatus: .onTime,
        latitude: 40.7128,
        longitude: -74.0060
    ),
    GlobalTrip(
        employeeName: "Sarah Chen",
        clientName: "Globex Inc",
        status: .planned,
        departureAirport: "JFK",
        arrivalAirport: "SFO",
        departureTime: "11:00 AM",
        arrivalTime: "2:20 PM",
        destinationCity: "San Francisco",
        dateRange: "Mar 3 – Mar 10",
        estimatedCost: "$1,870",
        flightStatus: .pending,
        latitude: 37.7749,
        longitude: -122.4194
    ),
    GlobalTrip(
        employeeName: "David Okafor",
        clientName: "Wayne Enterprises",
        status: .active,
        departureAirport: "LAX",
        arrivalAirport: "ORD",
        departureTime: "6:15 PM",
        arrivalTime: "12:10 AM",
        destinationCity: "Chicago",
        dateRange: "Feb 15 – Feb 22",
        estimatedCost: "$1,410",
        flightStatus: .delayed,
        latitude: 41.8781,
        longitude: -87.6298
    ),
    GlobalTrip(
        employeeName: "Emily Reyes",
        clientName: "Stark Industries",
        status: .completed,
        departureAirport: "DFW",
        arrivalAirport: "MIA",
        departureTime: "10:45 AM",
        arrivalTime: "3:10 PM",
        destinationCity: "Miami",
        dateRange: "Jan 28 – Feb 6",
        estimatedCost: "$1,120",
        flightStatus: .onTime,
        latitude: 25.7617,
        longitude: -80.1918
    ),
    GlobalTrip(
        employeeName: "James Park",
        clientName: "Oscorp",
        status: .planned,
        departureAirport: "SEA",
        arrivalAirport: "ATL",
        departureTime: "9:00 AM",
        arrivalTime: "4:45 PM",
        destinationCity: "Atlanta",
        dateRange: "Mar 12 – Mar 19",
        estimatedCost: "$1,380",
        flightStatus: .pending,
        latitude: 33.7490,
        longitude: -84.3880
    ),
    GlobalTrip(
        employeeName: "Aisha Williams",
        clientName: "LexCorp",
        status: .active,
        departureAirport: "ORD",
        arrivalAirport: "DEN",
        departureTime: "7:30 AM",
        arrivalTime: "9:15 AM",
        destinationCity: "Denver",
        dateRange: "Feb 20 – Feb 27",
        estimatedCost: "$980",
        flightStatus: .onTime,
        latitude: 39.7392,
        longitude: -104.9903
    ),
    GlobalTrip(
        employeeName: "Carlos Rivera",
        clientName: "Initech",
        status: .planned,
        departureAirport: "MIA",
        arrivalAirport: "IAH",
        departureTime: "1:00 PM",
        arrivalTime: "3:20 PM",
        destinationCity: "Houston",
        dateRange: "Mar 5 – Mar 12",
        estimatedCost: "$890",
        flightStatus: .pending,
        latitude: 29.7604,
        longitude: -95.3698
    ),
    GlobalTrip(
        employeeName: "Priya Patel",
        clientName: "Umbrella Corp",
        status: .active,
        departureAirport: "SFO",
        arrivalAirport: "SEA",
        departureTime: "4:00 PM",
        arrivalTime: "6:10 PM",
        destinationCity: "Seattle",
        dateRange: "Feb 17 – Feb 24",
        estimatedCost: "$760",
        flightStatus: .onTime,
        latitude: 47.6062,
        longitude: -122.3321
    ),
    GlobalTrip(
        employeeName: "Michael Torres",
        clientName: "Cyberdyne",
        status: .completed,
        departureAirport: "JFK",
        arrivalAirport: "BOS",
        departureTime: "8:00 AM",
        arrivalTime: "9:15 AM",
        destinationCity: "Boston",
        dateRange: "Feb 1 – Feb 8",
        estimatedCost: "$680",
        flightStatus: .onTime,
        latitude: 42.3601,
        longitude: -71.0589
    ),
    GlobalTrip(
        employeeName: "Jasmine Brooks",
        clientName: "Wonka Industries",
        status: .active,
        departureAirport: "DEN",
        arrivalAirport: "PHX",
        departureTime: "12:30 PM",
        arrivalTime: "1:45 PM",
        destinationCity: "Phoenix",
        dateRange: "Feb 19 – Feb 26",
        estimatedCost: "$720",
        flightStatus: .delayed,
        latitude: 33.4484,
        longitude: -112.0740
    ),
    GlobalTrip(
        employeeName: "Tyler Washington",
        clientName: "Massive Dynamic",
        status: .planned,
        departureAirport: "ATL",
        arrivalAirport: "MSP",
        departureTime: "10:00 AM",
        arrivalTime: "12:30 PM",
        destinationCity: "Minneapolis",
        dateRange: "Mar 8 – Mar 15",
        estimatedCost: "$1,050",
        flightStatus: .pending,
        latitude: 44.9778,
        longitude: -93.2650
    ),
    GlobalTrip(
        employeeName: "Natalie Kim",
        clientName: "Hooli",
        status: .active,
        departureAirport: "LAX",
        arrivalAirport: "LAS",
        departureTime: "3:00 PM",
        arrivalTime: "4:05 PM",
        destinationCity: "Las Vegas",
        dateRange: "Feb 21 – Feb 28",
        estimatedCost: "$640",
        flightStatus: .onTime,
        latitude: 36.1699,
        longitude: -115.1398
    ),
    GlobalTrip(
        employeeName: "Brandon Scott",
        clientName: "Pied Piper",
        status: .completed,
        departureAirport: "ORD",
        arrivalAirport: "DCA",
        departureTime: "7:00 AM",
        arrivalTime: "9:50 AM",
        destinationCity: "Washington D.C.",
        dateRange: "Feb 3 – Feb 10",
        estimatedCost: "$1,180",
        flightStatus: .onTime,
        latitude: 38.9072,
        longitude: -77.0369
    ),
    GlobalTrip(
        employeeName: "Rachel Nguyen",
        clientName: "Weyland-Yutani",
        status: .active,
        departureAirport: "DFW",
        arrivalAirport: "MSY",
        departureTime: "2:15 PM",
        arrivalTime: "4:00 PM",
        destinationCity: "New Orleans",
        dateRange: "Feb 16 – Feb 23",
        estimatedCost: "$820",
        flightStatus: .onTime,
        latitude: 29.9511,
        longitude: -90.0715
    ),
    GlobalTrip(
        employeeName: "Derek Hall",
        clientName: "Soylent Corp",
        status: .planned,
        departureAirport: "SEA",
        arrivalAirport: "PDX",
        departureTime: "5:30 PM",
        arrivalTime: "6:30 PM",
        destinationCity: "Portland",
        dateRange: "Mar 10 – Mar 17",
        estimatedCost: "$480",
        flightStatus: .pending,
        latitude: 45.5152,
        longitude: -122.6784
    ),
    GlobalTrip(
        employeeName: "Monica Adams",
        clientName: "Tyrell Corp",
        status: .active,
        departureAirport: "MIA",
        arrivalAirport: "CLT",
        departureTime: "9:45 AM",
        arrivalTime: "12:00 PM",
        destinationCity: "Charlotte",
        dateRange: "Feb 18 – Feb 25",
        estimatedCost: "$790",
        flightStatus: .delayed,
        latitude: 35.2271,
        longitude: -80.8431
    ),
    GlobalTrip(
        employeeName: "Kevin Yang",
        clientName: "Stark Industries",
        status: .completed,
        departureAirport: "SFO",
        arrivalAirport: "SAN",
        departureTime: "11:30 AM",
        arrivalTime: "12:50 PM",
        destinationCity: "San Diego",
        dateRange: "Feb 5 – Feb 12",
        estimatedCost: "$540",
        flightStatus: .onTime,
        latitude: 32.7157,
        longitude: -117.1611
    ),
    GlobalTrip(
        employeeName: "Olivia Foster",
        clientName: "Acme Corp",
        status: .active,
        departureAirport: "IAH",
        arrivalAirport: "AUS",
        departureTime: "8:00 AM",
        arrivalTime: "9:00 AM",
        destinationCity: "Austin",
        dateRange: "Feb 22 – Mar 1",
        estimatedCost: "$420",
        flightStatus: .onTime,
        latitude: 30.2672,
        longitude: -97.7431
    ),
    GlobalTrip(
        employeeName: "Andre Mitchell",
        clientName: "Globex Inc",
        status: .planned,
        departureAirport: "JFK",
        arrivalAirport: "PHL",
        departureTime: "6:30 AM",
        arrivalTime: "7:45 AM",
        destinationCity: "Philadelphia",
        dateRange: "Mar 1 – Mar 8",
        estimatedCost: "$380",
        flightStatus: .pending,
        latitude: 39.9526,
        longitude: -75.1652
    ),
    GlobalTrip(
        employeeName: "Samantha Cruz",
        clientName: "Initech",
        status: .active,
        departureAirport: "DEN",
        arrivalAirport: "SLC",
        departureTime: "2:00 PM",
        arrivalTime: "3:00 PM",
        destinationCity: "Salt Lake City",
        dateRange: "Feb 20 – Feb 27",
        estimatedCost: "$560",
        flightStatus: .onTime,
        latitude: 40.7608,
        longitude: -111.8910
    ),
    GlobalTrip(
        employeeName: "Jason Lee",
        clientName: "Wayne Enterprises",
        status: .completed,
        departureAirport: "ATL",
        arrivalAirport: "BNA",
        departureTime: "10:15 AM",
        arrivalTime: "11:15 AM",
        destinationCity: "Nashville",
        dateRange: "Feb 7 – Feb 14",
        estimatedCost: "$590",
        flightStatus: .onTime,
        latitude: 36.1627,
        longitude: -86.7816
    ),
    GlobalTrip(
        employeeName: "Lauren White",
        clientName: "Cyberdyne",
        status: .active,
        departureAirport: "LAX",
        arrivalAirport: "DTW",
        departureTime: "7:45 AM",
        arrivalTime: "3:30 PM",
        destinationCity: "Detroit",
        dateRange: "Feb 17 – Feb 24",
        estimatedCost: "$1,310",
        flightStatus: .delayed,
        latitude: 42.3314,
        longitude: -83.0458
    ),
    GlobalTrip(
        employeeName: "Chris Evans",
        clientName: "LexCorp",
        status: .planned,
        departureAirport: "ORD",
        arrivalAirport: "MCI",
        departureTime: "4:30 PM",
        arrivalTime: "6:15 PM",
        destinationCity: "Kansas City",
        dateRange: "Mar 6 – Mar 13",
        estimatedCost: "$670",
        flightStatus: .pending,
        latitude: 39.0997,
        longitude: -94.5786
    ),
    GlobalTrip(
        employeeName: "Hannah Garcia",
        clientName: "Massive Dynamic",
        status: .active,
        departureAirport: "DFW",
        arrivalAirport: "MCO",
        departureTime: "9:00 AM",
        arrivalTime: "1:00 PM",
        destinationCity: "Orlando",
        dateRange: "Feb 19 – Feb 26",
        estimatedCost: "$940",
        flightStatus: .onTime,
        latitude: 28.5383,
        longitude: -81.3792
    ),
    GlobalTrip(
        employeeName: "Ryan Cooper",
        clientName: "Hooli",
        status: .completed,
        departureAirport: "SEA",
        arrivalAirport: "HNL",
        departureTime: "8:30 AM",
        arrivalTime: "12:15 PM",
        destinationCity: "Honolulu",
        dateRange: "Jan 25 – Feb 3",
        estimatedCost: "$2,150",
        flightStatus: .onTime,
        latitude: 21.3069,
        longitude: -157.8583
    )
]

// MARK: - Main View

struct GlobalTripsView: View {
    @State private var searchText = ""
    @State private var selectedFilter = 0
    @State private var showMap = false

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    HStack(spacing: 10) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.secondary)
                        TextField("Search trips, employees...", text: $searchText)
                            .font(.subheadline)
                    }
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)

                    Picker("Filter", selection: $selectedFilter) {
                        Text("All").tag(0)
                        Text("My Trips").tag(1)
                        Text("Active").tag(2)
                    }
                    .pickerStyle(.segmented)

                    Button {
                        showMap = true
                    } label: {
                        HStack {
                            Image(systemName: "globe.americas.fill")
                            Text("View Global Map")
                                .fontWeight(.semibold)
                        }
                        .font(.subheadline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color("BrandTeal"))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }

                    ForEach(sampleTrips) { trip in
                        GlobalTripCard(trip: trip)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                .padding(.bottom, 40)
            }
            .background(Color(.systemBackground))
            .navigationTitle("Global Trips")
            .fullScreenCover(isPresented: $showMap) {
                GlobalTripsMapView(trips: sampleTrips)
            }
        }
    }
}

// MARK: - Map View

struct GlobalTripsMapView: View {
    let trips: [GlobalTrip]
    @Environment(\.dismiss) private var dismiss
    @State private var camera: MapCameraPosition = .automatic

    var body: some View {
        ZStack(alignment: .topLeading) {
            Map(position: $camera) {
                ForEach(trips) { trip in
                    Annotation(trip.employeeName, coordinate: CLLocationCoordinate2D(
                        latitude: trip.latitude, longitude: trip.longitude
                    )) {
                        TripMapPin(trip: trip)
                    }
                }
            }
            .mapStyle(.standard(elevation: .realistic))
            .ignoresSafeArea()

            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(Color("BrandDarkTeal"))
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
            }
            .padding(.top, 54)
            .padding(.leading, 16)
        }
        .sheet(isPresented: .constant(true)) {
            MapTripListSheet(trips: trips)
                .presentationDetents([.fraction(0.3), .medium, .large])
                .presentationDragIndicator(.visible)
                .presentationBackgroundInteraction(.enabled(upThrough: .medium))
                .interactiveDismissDisabled()
        }
    }
}

// MARK: - Map Pin

struct TripMapPin: View {
    let trip: GlobalTrip

    var body: some View {
        VStack(spacing: 2) {
            Image(systemName: "airplane.circle.fill")
                .font(.title2)
                .foregroundColor(trip.status.color)
                .background(Circle().fill(.white).padding(2))

            Text(trip.destinationCity)
                .font(.caption2.weight(.semibold))
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(.ultraThinMaterial)
                .cornerRadius(4)
        }
    }
}

// MARK: - Bottom Sheet

struct MapTripListSheet: View {
    let trips: [GlobalTrip]

    var body: some View {
        NavigationStack {
            List(trips) { trip in
                MapTripRow(trip: trip)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
            }
            .listStyle(.plain)
            .navigationTitle("Team Flights")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MapTripRow: View {
    let trip: GlobalTrip

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                HStack(spacing: 4) {
                    Circle()
                        .fill(trip.flightStatus.color)
                        .frame(width: 7, height: 7)
                    Text(trip.flightStatus.rawValue)
                        .font(.caption2.weight(.medium))
                        .foregroundColor(trip.flightStatus.color)
                }

                Spacer()

                Text(trip.status.rawValue)
                    .font(.caption2.weight(.semibold))
                    .foregroundColor(trip.status.color)
            }

            Text("\(trip.departureAirport) → \(trip.arrivalAirport)")
                .font(.headline)
                .foregroundColor(Color("BrandDarkTeal"))

            Text("\(trip.destinationCity)  ·  \(trip.employeeName)")
                .font(.subheadline)
                .foregroundColor(.secondary)

            HStack {
                Text(trip.departureTime)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Image(systemName: "arrow.right")
                    .font(.caption2)
                    .foregroundColor(Color("BrandTeal"))
                Text(trip.arrivalTime)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(14)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color("BrandTeal").opacity(0.15), lineWidth: 1)
        )
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.04), radius: 3, x: 0, y: 1)
    }
}

// MARK: - Trip Card

struct GlobalTripCard: View {
    let trip: GlobalTrip

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(trip.employeeName)
                        .font(.headline)
                        .foregroundColor(Color("BrandDarkTeal"))
                    Text(trip.clientName)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                Spacer()

                Text(trip.status.rawValue)
                    .font(.caption.weight(.semibold))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(trip.status.color.opacity(0.15))
                    .foregroundColor(trip.status.color)
                    .cornerRadius(8)
            }

            Divider()

            HStack(spacing: 6) {
                flightLabel(trip.departureAirport, time: trip.departureTime)
                Image(systemName: "airplane")
                    .font(.caption)
                    .foregroundColor(Color("BrandTeal"))
                flightLabel(trip.arrivalAirport, time: trip.arrivalTime)
            }

            HStack {
                Label(trip.destinationCity, systemImage: "mappin.and.ellipse")
                    .font(.subheadline)
                    .foregroundColor(Color("BrandDarkTeal"))

                Spacer()

                Text(trip.dateRange)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            HStack {
                Text(trip.estimatedCost)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(Color("BrandDarkTeal"))

                Spacer()

                HStack(spacing: 4) {
                    Circle()
                        .fill(trip.flightStatus.color)
                        .frame(width: 7, height: 7)
                    Text(trip.flightStatus.rawValue)
                        .font(.caption2.weight(.medium))
                        .foregroundColor(trip.flightStatus.color)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(trip.flightStatus.color.opacity(0.1))
                .cornerRadius(6)
            }
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

    private func flightLabel(_ airport: String, time: String) -> some View {
        VStack(spacing: 2) {
            Text(airport)
                .font(.subheadline.weight(.bold))
                .foregroundColor(Color("BrandDarkTeal"))
            Text(time)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    GlobalTripsView()
}
