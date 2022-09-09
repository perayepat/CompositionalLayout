

import Foundation

struct Video: Decodable {
  let url: String
  let title: String
}

//using instance of url as the unique component
extension Video: Hashable{
    func has(into hasher: inout Hasher){
        hasher.combine(url)
    }
}

extension Video: Equatable {
  static func == (lhs: Video, rhs: Video) -> Bool {
    return lhs.url == rhs.url
  }
}


