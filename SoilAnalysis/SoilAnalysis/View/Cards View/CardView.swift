//
//  CardView.swift
//  SoilAnalysis
//
//  Created by Marcin Dytko on 04/02/2024.
//

import SwiftUI

struct CardView: View {
    // MARK: - Properites

    var person: String
    @State private var offset = CGSize.zero
    @State private var color = Color.black
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 320, height: 420)
                .border(.white, width: 6.0)
                .cornerRadius(4)
                .foregroundColor(color.opacity(0.9))
                .shadow(radius: 4)
            
            HStack {
                Text(person)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
            }
        }
        .offset(x: offset.width, y: offset.height * 0.4)
        .rotationEffect(.degrees(Double(offset.width / 40)))
        .gesture(
        DragGesture()
            .onChanged { gesture in
                offset = gesture.translation
                withAnimation {
                    changeColor(width: offset.width)
                }
            }
            .onEnded { _ in
                withAnimation {
                    swipeCard(width: offset.width)
                }
            }
        )
    }
    
    func swipeCard(width: CGFloat) {
        switch width {
        case -500 ... (-150):
            offset = CGSize(width: -500, height: 0)
        case 150 ... 500:
            offset = CGSize(width: 500, height: 0)
        default:
            offset = .zero
        }
    }
    
    func changeColor(width: CGFloat) {
        switch width {
        case -500 ... (-130):
            color = .red
            
        case 130 ... 500:
            color = .green
            
        default:
            color = .black
        }
    }
}

// MARK: - Preview
#Preview {
    CardView(person: "Mario")
}
