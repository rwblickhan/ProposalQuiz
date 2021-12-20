//
//  ContentView.swift
//  ProposalQuiz
//
//  Created by Russell Blickhan on 12/18/21.
//

import SwiftUI

struct ContentView: View {
    private enum ItemState {
        case noAnswer
        case correct
        case incorrect
    }
    
    @State private var currentItemIndex: Int = 0
    @State private var itemState: ItemState = .noAnswer
    private let items: [QuizItem]
    private var isAtEnd: Bool { currentItemIndex == items.count - 1}
    
    init() {
        items = Bundle.main.decode([QuizItem].self, from: "data.json")
    }
    
    var body: some View {
        List {
            topLabel.padding()
            if itemState != .correct {
                ForEach(items[currentItemIndex].options) {
                    button(for: $0)
                }
            }
            switch itemState {
            case .correct where !isAtEnd:
                Button(action: {
                    currentItemIndex += 1
                    itemState = .noAnswer
                }, label: {
                    Text("Turn to the next page, then tap here!")
                })
            case .incorrect:
                Text("Sorry, try again!").foregroundColor(.red)
            case .correct, .noAnswer:
                EmptyView()
            }
        }
    }
    
    private var topLabel: some View {
        switch itemState {
        case .correct where isAtEnd:
            return Text("Hooray!")
        case .correct:
            return Text("Correct!")
        case .noAnswer, .incorrect:
            return Text(items[currentItemIndex].question)
        }
    }
    
    private func button(for option: QuizOption) -> some View {
        Button(action: {
            itemState = option.correct ? .correct : .incorrect
        }, label: {
            Text(option.answer)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
