
import Foundation

struct Section:Decodable, Hashable {
    let identifier = UUID().uuidString
    let title: String
    let videos: [Video]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func ==(lhs: Section, rhs: Section) -> Bool{
        return lhs.title == rhs.title
    }
}
