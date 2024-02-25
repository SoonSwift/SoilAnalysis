//
//  MainViewFeature.swift
//  SoilAnalysis
//
//  Created by Marcin Dytko on 18/01/2024.
//

import SwiftUI
import ComposableArchitecture

private enum SoilManagerKey: DependencyKey {
    static var liveValue: SoilManagerPrototype = SoilManager() as! SoilManagerPrototype
    //static var previewValue: ValorantManagerPrototype = MockValorantManager()
}

extension DependencyValues {
    var soilManager: SoilManagerPrototype {
        get { self[SoilManagerKey.self] }
        set { self[SoilManagerKey.self] = newValue }
    }
}

struct MainFeature: Reducer {
    @Dependency(\.soilManager)
    private var soilManager
    
    
    struct State: Equatable {
        @PresentationState var addSoil: AddSoilFeature.State?
        var soilTest = SoilTestsModel(name: "Soil 1", description: Description(id: UUID(), description: "Once i was a ground but now i'm a solid soil :)"), date: Date.now)
        var soilTests: [SoilTestsModel]
        var isActivityIndicatorVisible = false

    }
    
    enum Action: Equatable {
        case addSoil(PresentationAction<AddSoilFeature.Action>)
        case addButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addSoil:
                return .none
            
            case .addButtonTapped:
                state.isActivityIndicatorVisible = true
                state.addSoil = .init(name: "haha")
                return .none
            
            }
        }
        .ifLet(\.$addSoil, action: /Action.addSoil) {
          AddSoilFeature()
        }
    }
}
