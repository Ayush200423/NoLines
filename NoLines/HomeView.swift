import SwiftUI

struct HomeView: View {
    
    @State var searchLocationsText: String = ""
    @ObservedObject var model = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10.0) {
                TextField("Search", text: $searchLocationsText)
                    .padding()
                    .background(Color.gray.opacity(0.1).cornerRadius(10))
                    .foregroundColor(.blue)
                    .font(.headline)
                
                List(model.list) { item in
                    HStack {
                        VStack (alignment: .leading) {
                            Text("\(item.store)")
                                .font(.title2)
                            Text("Line: \(String(item.wait_time)) min")
                            Text("Rating: \(String(item.rating)) / 10")
                            Text("Address: \(String(item.address))")
                            switch item.wait_time {
                            case item.wait_time where item.wait_time >= 20:
                                Text("Very Busy")
                                    .fontWeight(.bold)
                                    .foregroundColor(.red)
                            case item.wait_time where item.wait_time >= 10 && item.wait_time < 20:
                                Text("Busy")
                                    .fontWeight(.bold)
                                    .foregroundColor(.orange)
                            case item.wait_time where item.wait_time >= 5 && item.wait_time < 10:
                                Text("Moderately busy")
                                    .fontWeight(.bold)
                                    .foregroundColor(.yellow)
                            default:
                                Text("Not Busy")
                                    .fontWeight(.bold)
                                    .foregroundColor(.green)
                            }
                            }
                        .padding()
                        }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.blue, lineWidth: 2)
                )
                VStack {
                    Text("NoLines is Designed to Help You Save Time!")
                    Text("Search For Stores Above")
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Search")
        }
    }
    init() {
        model.getData()
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
