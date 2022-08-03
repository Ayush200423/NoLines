import SwiftUI

struct UpdateView: View {
    @State var StoreName: String
    @State var StoreAddress: String
    
    @State var Updated = false
    @State var WaitTimeCounter = 0
    @State var RatingCounter = 1
    
    @ObservedObject var model = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30.0) {
                VStack {
                    Text("Store: \(self.StoreName)")
                        .font(.title2)
                    Text("Address: \(self.StoreAddress)")
                        .font(.title3)
                }
                
                VStack {
                    Text("How Long Did You Wait in Line?")
                    .bold()
                    .font(.headline)
                
                    Stepper("Minutes: \(WaitTimeCounter)", value: $WaitTimeCounter, in: 0...9999)
                    .padding()
                }
                
                VStack {
                    Text("How Was Your Overall Experience? (On a scale of 1-10)")
                    .bold()
                
                    Stepper("Rating: \(RatingCounter)", value: $RatingCounter, in: 1...10)
                    .padding()
                }
            
                if Updated == false {
                    Button(action: {
                        SubmitData()
                    }, label: {
                        Text("Submit".uppercased())
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .font(.headline)
                            .background(Color.blue.cornerRadius(10))
                    })
                } else {
                    Button(action: {
                        // skip
                    }, label: {
                        Text("Submit".uppercased())
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .font(.headline)
                            .background(Color.gray.cornerRadius(10))
                    })
                    .disabled(true)
                    
                    VStack {
                        Text("Thank you.")
                        Text("Your Submission Has Been Recieved.")
                    }
                    .font(.system(size: 15))
                }
                Spacer()
            }
        }
        .padding()
        .navigationTitle("Update")
    }
    
    func SubmitData() {
        model.updateData(storeToUpdate: StoreName, wait_time: WaitTimeCounter, rating: RatingCounter, storeAddress: StoreAddress)
        Updated = true
    }
}

struct UpdateView_Previews: PreviewProvider {
    @State static var storeName: String = ""
    @State static var storeAddress: String = ""
    static var previews: some View {
        UpdateView(StoreName: storeName, StoreAddress: storeAddress)
    }
}
