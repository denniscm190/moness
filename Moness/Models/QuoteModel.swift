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

struct QuoteBatchResponse: Codable {
    var message: [String: QuoteBatchNestedResponse]
}

struct QuoteBatchNestedResponse: Codable {
    var quote: QuoteResult
}

struct QuoteResult: Codable {
    var latestPrice: Float
    var changePercent: Float
    var change: Float
}
