//
//  DataSource.swift
//  RayWenderlichLibrary
//
//  Created by Pat on 2022/09/07.
//  Copyright © 2022 Ray Wenderlich. All rights reserved.
//

import Foundation

class DataSource {
    static let shared = DataSource()
    var tutorials: [TutorialCollection]
    private let decoder = PropertyListDecoder()
    
    private init(){
        guard let url  = Bundle.main.url(forResource: "Tutorials", withExtension: "plist"),
        let data = try? Data(contentsOf: url),
        let tutorials = try? decoder.decode([TutorialCollection].self, from: data) else {
            self.tutorials = []
            return
        }
        
        self.tutorials = tutorials
    }
}


 
