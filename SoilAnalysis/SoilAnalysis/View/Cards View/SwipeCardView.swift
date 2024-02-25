//
//  SwipeCardView.swift
//  SoilAnalysis
//
//  Created by Marcin Dytko on 04/02/2024.
//

import SwiftUI

struct SwipeCardView: View {
    private var people: [String] = ["Marcin", "Julia", "Dariusz"]
    var body: some View {
        VStack {
            ZStack {
                ForEach(people, id: \.self) { person in
                    CardView(person: person)
                }
            }
        }
    }
}

#Preview {
    SwipeCardView()
}
