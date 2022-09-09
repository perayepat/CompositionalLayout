

import Foundation

struct TutorialCollection: Decodable, Hashable {
  let title: String
  let tutorials: [Tutorial]
  let identifier = UUID().uuidString
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(identifier)
  }
  
  static func == (lhs: TutorialCollection, rhs: TutorialCollection) -> Bool {
    return lhs.identifier == rhs.identifier
  }
}
