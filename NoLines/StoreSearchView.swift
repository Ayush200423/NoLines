import SwiftUI
import MapKit

struct StoreSearchView: View {
    
    @State var StoreName: String = ""
    @State private var tapped: Bool = false
    @State private var landmarks: [Landmark] = [Landmark]()
    
    private func getNearByLandmarks() {
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = StoreName
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if let response = response {
                
                let mapItems = response.mapItems
                self.landmarks = mapItems.map {
                    Landmark(placemark: $0.placemark)
                }
            }
        }
    }
    
    func calculateOffset() -> CGFloat {
        
        if self.landmarks.count > 0 && !self.tapped {
            return UIScreen.main.bounds.size.height - UIScreen.main.bounds.size.height / 1.5
        }
        else if self.tapped {
            return 100
        } else {
            return UIScreen.main.bounds.size.height
        }
    }
    
    var body: some View {
        VStack(spacing: 30.0) {
            ZStack(alignment: .top) {
                HStack {
                    TextField("Store Name", text: $StoreName).padding()
                        .background(Color.gray.opacity(0.1).cornerRadius(10))
                        .foregroundColor(.blue)
                        .font(.headline)
                    
                    Button(action: {
                        self.getNearByLandmarks()
                    }, label: {
                        Text("Find".uppercased())
                            .padding()
                            .frame(width: 100)
                            .foregroundColor(.white)
                            .font(.headline)
                            .background(Color.blue.cornerRadius(10))
                    })
                }.padding()
                    
                    StoresListView(landmarks: self.landmarks) {
                        self.tapped.toggle()
                    }.offset(y: calculateOffset())
                }
        }
    }
}

struct StoreSearchView_Previews: PreviewProvider {
    static var previews: some View {
        StoreSearchView()
    }
}
