import UIKit

struct ActorModel {
  
  var name: String
  var status: String
  var image: String
  
  init(_ name: String,_ status: String,_ image: String) {
    self.name = name
    self.status = status
    self.image = image
  }
}
