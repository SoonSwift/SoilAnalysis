//
//  ContentView.swift
//  SoilAnalysis
//
//  Created by Marcin Dytko on 18/01/2024.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    var store = Store(
        initialState: MainFeature.State(soilTests: [SoilTestsModel(name: "haha",
                                                                   description: Description(id: UUID(), description: "da"), date: Date.now)])) {
        MainFeature()
    }
    
    var body: some View {
        WithViewStore(self.store, observe: {$0}) { viewStore in
            NavigationStack {
                VStack {
                    List {
                        
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button {
                            viewStore.send(.addButtonTapped)
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(store: self.store.scope(state: \.$addSoil, action: { .addSoil($0)})) { store in
                    AddSoilView(store: store)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
