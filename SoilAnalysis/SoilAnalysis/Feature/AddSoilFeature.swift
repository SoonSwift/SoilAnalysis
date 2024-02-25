//
//  AddSoilFeature.swift
//  SoilAnalysis
//
//  Created by Marcin Dytko on 04/02/2024.
//

import Foundation
import ComposableArchitecture

struct AddSoilFeature: Reducer {
    
    @Dependency(\.soilManager)
    private var soilManager
    
    struct State: Equatable {
        var name = ""
        var date = Date.now
    }
    
    enum Action: Equatable {
        case nameChanged(String)
        case dateChanged(Date)
        case saveButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case let .nameChanged(name):
                state.name = name
                return .none
                
            case let .dateChanged(date):
                state.date = date
                return .none
                
            case .saveButtonTapped:
                return .none
            }
        }
    }
    
}
