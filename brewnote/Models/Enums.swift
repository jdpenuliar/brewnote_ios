//
//  Enums.swift
//  brewnote
//
//  Created by JD Penuliar on 3/17/26.
//

import Foundation

enum Species: String, Codable, CaseIterable {
    case arabica = "ARABICA"
    case robusta = "ROBUSTA"
    case liberica = "LIBERICA"
    case excelsa = "EXCELSA"
}

enum Grind: String, Codable, CaseIterable {
    case extraCoarse = "EXTRA_COARSE"
    case coarse = "COARSE"
    case mediumCoarse = "MEDIUM_COARSE"
    case medium = "MEDIUM"
    case mediumFine = "MEDIUM_FINE"
    case fine = "FINE"
    case extraFine = "EXTRA_FINE"
}

enum Roast: String, Codable, CaseIterable {
    case light = "LIGHT"
    case mediumLight = "MEDIUM_LIGHT"
    case medium = "MEDIUM"
    case mediumDark = "MEDIUM_DARK"
    case dark = "DARK"
}

enum WeightType: String, Codable, CaseIterable {
    case grams = "GRAMS"
    case ounces = "OUNCES"
}

enum TemperatureType: String, Codable, CaseIterable {
    case celsius = "CELSIUS"
    case fahrenheit = "FAHRENHEIT"
}
