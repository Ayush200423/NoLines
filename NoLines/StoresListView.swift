import SwiftUI
import MapKit

struct StoresListView: View {
    
    let landmarks: [Landmark]
    var onTap: () -> ()
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                EmptyView()
            }.frame(width: UIScreen.main.bounds.size.width, height: 60)
                .background(.blue)
                .gesture(TapGesture()
                    .onEnded(self.onTap))
            
            NavigationView {
            List {
                ForEach(self.landmarks, id: \.id) { landmark in
                    NavigationLink(destination: UpdateView(StoreName: landmark.name, StoreAddress: landmark.title)) {
                    VStack(alignment: .leading) {
                        Text(landmark.name)
                            .fontWeight(.bold)
                        Text(landmark.title)
                    }
                }
            }
            }
            }
        }.cornerRadius(10)
    }
}

struct StoresListView_Previews: PreviewProvider {
    static var previews: some View {
        StoresListView(landmarks: [Landmark(placemark: MKPlacemark())], onTap: {})
    }
}
