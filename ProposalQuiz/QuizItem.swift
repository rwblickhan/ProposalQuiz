//
//  QuizItem.swift
//  ProposalQuiz
//
//  Created by Russell Blickhan on 12/18/21.
//

import Foundation

struct QuizOption: Codable, Identifiable {
    var id: String
    var answer: String
    var correct: Bool
}

struct QuizItem: Codable {
    var question: String
    var options: [QuizOption]
}
