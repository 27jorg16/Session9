//
//  Models.swift
//  Session9
//
//  Created by DAMII on 17/12/24.
//

import Foundation

struct Tag : Codable, Identifiable, Hashable{
    let id: Int
    let name: String
}

struct Category : Codable, Identifiable, Hashable, Equatable{
    let id: Int
    let name: String
}

struct Priority : Codable, Identifiable, Hashable{
    let id: Int
    let name: String
}
