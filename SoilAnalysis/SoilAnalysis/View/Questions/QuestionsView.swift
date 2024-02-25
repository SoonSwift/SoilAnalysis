//
//  QuestionsView.swift
//  SoilAnalysis
//
//  Created by Marcin Dytko on 10/02/2024.
//

import SwiftUI
import ComposableArchitecture

struct QuestionViewFeature: Reducer {
    
    struct State: Equatable {
        
        var currentNode: Node = .question(
            QuestionNode(
                question: "Czy grunt został osadzony w wyniku procesów naturalnych?",
                answerYes: .question(
                    QuestionNode(
                        question: "Czy zawiera substancje organiczne i ma organiczny zapach?",
                        answerYes: .answer(AnswerNode(response: "Grunt Organiczny")),
                        answerNo: .question(
                            QuestionNode(
                                question: "Czy grunt ma małą gęstość?",
                                answerYes: .answer(AnswerNode(response: "Grunt Wulkaniczny")),
                                answerNo: .question(QuestionNode(
                                    question: "Czy głazy i kamienie ważą więcej niż pozostały gurnt?",
                                    answerYes: .question(QuestionNode(
                                        question: "Czy większość okruchów jest powyżej 200mm",
                                        answerYes: .answer(AnswerNode(response: "Głazy")),
                                        answerNo: .answer(AnswerNode(response: "Kamienie")))
                                    ),
                                    answerNo: .question(QuestionNode(
                                        question: "Czy grunt zlepia się gdy jest mokry?",
                                        answerYes: .question(QuestionNode(
                                            question: "Czy grunt wykazuje niską plastyczność?",
                                            answerYes: .answer(AnswerNode(response: "pył")),
                                            answerNo: .answer(AnswerNode(response: "ił")))),
                                        answerNo: .question(QuestionNode(
                                            question: "Czy wiekszosc okruchow jest powyzej 2 mm",
                                            answerYes: .answer(AnswerNode(response: "żwir")),
                                            answerNo: .answer(AnswerNode(response: "Piasek")))))
                                    )
                                )
                                )
                            )
                        )
                    )
                ),
                answerNo: .question(
                    QuestionNode(
                        question: "Grunt antoropogeniczny",
                        answerYes: .answer(AnswerNode(response: "Grunt Antropogeniczny"))
                        ,
                        answerNo: .answer(AnswerNode(response: "Grunt Antropogeniczny"))
                    )
                )
            )
        )
        
    }
    
    enum Action: Equatable {
        case buttonYesTapped
        case buttonNoTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .buttonYesTapped:
                if case let .question(questionNode) = state.currentNode {
                    state.currentNode = questionNode.answerYes
                }
            case .buttonNoTapped:
                if case let .question(questionNode) = state.currentNode {
                    state.currentNode = questionNode.answerNo
                }
            }
            return .none
        }
    }
}

indirect enum Node: Equatable {
    case question(QuestionNode)
    case answer(AnswerNode)
}

struct AnswerNode: Equatable{
    var response: String
}

struct QuestionNode: Equatable {
  //  var previousQuestion: Node?
    var question: String
    var answerYes: Node
    var answerNo: Node
}

struct QuestionsView: View {
    @State var store = Store(initialState: QuestionViewFeature.State()) {
        QuestionViewFeature()
    }

    var body: some View {
        WithViewStore(self.store, observe: {$0}) { viewStore in
            VStack {
                switch viewStore.currentNode {
                case let .question(questionNode):
                    Text(questionNode.question)
                        .padding()
                    HStack {
                        Button("Tak") {
                            viewStore.send(.buttonYesTapped)
                        }
                        .padding()
                        
                        Button("Nie") {
                            viewStore.send(.buttonNoTapped)
                        }
                        .padding()
                    }
                    
                case let .answer(answerNode):
                    Text(answerNode.response)
                        .padding()
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionsView()
    }
}

