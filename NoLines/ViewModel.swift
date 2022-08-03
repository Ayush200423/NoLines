import Foundation
import Firebase

class ViewModel : ObservableObject {
    @Published var list = [Store]()
    
    func addData(store: String, wait_time: Int, rating: Int, address: String) {
        let db = Firestore.firestore()
        
        db.collection("stores").addDocument(data: ["store":store, "wait_time":wait_time, "rating":rating, "address":address]) { error in
            if error == nil {
                self.getData()
            } else {
                
            }
        }
    }
    
    func updateData(storeToUpdate: String, wait_time: Int, rating: Int, storeAddress: String) {
        let db = Firestore.firestore()
        
        db.collection("stores").whereField("store", isEqualTo: storeToUpdate).getDocuments { QuerySnapshot, Error in
            if Error != nil {
                print("Error getting docs")
            } else {
                for document in QuerySnapshot!.documents {
                    let updated_wait_time = Int(floor((Float(document["wait_time"] as? Float ?? 0.0) * 0.65) + (Float(wait_time) * 0.35)))
                    let updated_rating = Int(floor((Float(document["rating"] as? Float ?? 0.0) * 0.65) + (Float(rating) * 0.35)))
                    db.collection("stores").document(document.documentID).updateData(["wait_time" : updated_wait_time, "rating" : updated_rating,])
                    return
                }
                self.addData(store: storeToUpdate, wait_time: wait_time, rating: rating, address: storeAddress)
            }
        }
    }
    
    func getData() {
        let db = Firestore.firestore()
        
        db.collection("stores").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.list = snapshot.documents.map { d in
                            return Store(id: d.documentID, store: d["store"] as? String ?? "", wait_time: d["wait_time"] as? Int ?? 0, rating: d["rating"] as? Int ?? 0, address: d["address"] as? String ?? "")
                        }
                    }
                }
            } else {
                
            }
        }
    }
}
