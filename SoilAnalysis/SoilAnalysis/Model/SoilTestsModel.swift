//
//  SoilTestsModel.swift
//  SoilAnalysis
//
//  Created by Marcin Dytko on 18/01/2024.
//

import Foundation

struct SoilTestsModel: Equatable, Identifiable, Codable {
    var id = UUID()
    var name: String
    var description: Description
    var date: Date
}

struct Description: Equatable, Identifiable, Codable{
    var id = UUID()
    var description: String
}
