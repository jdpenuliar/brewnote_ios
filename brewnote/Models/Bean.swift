//
//  Bean.swift
//  brewnote
//
//  Created by JD Penuliar on 3/17/26.
//

import Foundation

struct Bean: Codable, Identifiable {
    let id: String
    var name: String
    var species: [Species]
    var countryOfOrigin: String
    var openFoodFactsId: String?
    var createdById: String
    var createdAt: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, species, countryOfOrigin, openFoodFactsId, createdById, createdAt
    }
}
