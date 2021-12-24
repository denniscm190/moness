//
//  SearchCompanyModel.swift
//  Moness
//
//  Created by Dennis Concepción Martín on 24/12/21.
//

import Foundation

struct SearchCompanyResponse: Codable {
    var message: [SearchCompanyResult]
}

struct SearchCompanyResult: Codable, Hashable {
    var symbol: String
    var cik: String?
    var securityName: String?
    var securityType: String?
    var region: String?
    var exchange: String?
    var sector: String?
    var currency: String?
}
