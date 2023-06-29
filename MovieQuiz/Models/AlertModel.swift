//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by 1 on 26.06.2023.
//

import UIKit

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let completion: (()->Void)?
}
