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
    private var isAtEnd: Bool { currentItemIndex == items.count - 1 }

    init() {
        items = Bundle.main.decode([QuizItem].self, from: "data.json")
    }

    var body: some View {
        List {
            topLabel.padding()
            switch itemState {
            case .correct where !isAtEnd:
                Button(action: {
                    currentItemIndex += 1
                    itemState = .noAnswer
                }, label: {
                    Text("Turn to the next page, then tap here!")
                })
            case .noAnswer:
                optionButtons
            case .incorrect:
                optionButtons
                Text("Sorry, try again!").foregroundColor(.red)
            case .correct:
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

    private var optionButtons: some View {
        ForEach(items[currentItemIndex].options.shuffled()) {
            button(for: $0)
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
