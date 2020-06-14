//
//  File.swift
//  
//
//  Created by Florian Heiber on 14.06.2020.
//

import Foundation

struct Line {
    let number: Int
    let content: String

    func qualifies(for keyword: String) -> Bool {
        return content.contains(keyword)
    }
}
