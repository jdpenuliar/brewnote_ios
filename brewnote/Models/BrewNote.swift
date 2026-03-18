//
//  BrewNote.swift
//  brewnote
//
//  Created by JD Penuliar on 3/17/26.
//

import Foundation

struct BrewNote: Codable, Identifiable {
    let id: String
    var brewMethod: String
    var grind: Grind?
    var roast: Roast?
    var beansWeight: Double?
    var beansWeightType: WeightType?
    var brewTime: Int?
    var brewTemperature: Double?
    var brewTemperatureType: TemperatureType?
    var waterToGrindRatio: String?
    var rating: Double?
    var notes: String?
    var beans: [Bean]?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case brewMethod, grind, roast, beansWeight, beansWeightType
        case brewTime, brewTemperature, brewTemperatureType
        case waterToGrindRatio, rating, notes, beans
    }
}
