//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by 1 on 26.06.2023.
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)
}
