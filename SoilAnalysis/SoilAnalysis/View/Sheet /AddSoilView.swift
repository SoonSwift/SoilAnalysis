//
//  AddSoilView.swift
//  SoilAnalysis
//
//  Created by Marcin Dytko on 04/02/2024.
//

import SwiftUI
import ComposableArchitecture

struct AddSoilView: View {
    @State var store = Store(initialState: AddSoilFeature.State()) {
        AddSoilFeature()
    }
    var body: some View {
        WithViewStore(self.store, observe: {$0}) { viewStore in
            VStack {
                TextField("Name", text: viewStore.binding(
                    get: \.name,
                    send: {.nameChanged($0)})
                )
                
                DatePicker("Date of test", selection: viewStore.binding(
                get: \.date,
                send: { .dateChanged($0)}),
                in: ...Date.now,
                displayedComponents: .date
                )
                
                Text(viewStore.name)
                Text(viewStore.date.description)
            }
        }
    }
}

#Preview {
    AddSoilView(store: Store(initialState: AddSoilFeature.State(), reducer: {
        AddSoilFeature()
    }))
}

