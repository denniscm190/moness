//
//  QuoteModel.swift
//  Moness
//
//  Created by Dennis Concepción Martín on 24/12/21.
//

import Foundation

struct QuoteResponse: Codable {
    var message: QuoteResult
}

struct QuoteResult: Codable {
    var latestPrice: Float
    var changePercent: Double
}
