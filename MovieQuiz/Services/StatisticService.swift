//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by 1 on 26.06.2023.
//

import Foundation

private enum Keys: String {
    case correct, total, bestGame, gamesCount
}

protocol StatisticService {
    func store(correct count: Int, total amount: Int)
    var totalAccuracy: Double { get } // точность
    var gamesCount: Int { get } //кол-во игр
    var bestGame: GameRecord { get } //дучшая игра
}

final class StatisticServiceImplementation: StatisticService {
    let userDefaults = UserDefaults.standard

    var totalAccuracy: Double {
        let correct = userDefaults.double(forKey: Keys.correct.rawValue)
        let total = userDefaults.double(forKey: Keys.total.rawValue)

        return correct / total * 100
    }

    var gamesCount: Int {
        get{
            let count = userDefaults.integer(forKey: Keys.gamesCount.rawValue)
            return count
        }
        set{
            userDefaults.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }

    var bestGame: GameRecord {
        get {
            guard let data = userDefaults.data(forKey: Keys.bestGame.rawValue),
            let record = try? JSONDecoder().decode(GameRecord.self, from: data) else {
                return .init(correct: 0, total: 0, date: Date())
            }

            return record
        }

        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                print("Невозможно сохранить результат")
                return
            }
            userDefaults.set(data, forKey: Keys.bestGame.rawValue)
        }
    }

    func store(correct count: Int, total amount: Int) {
        userDefaults.set(count, forKey: Keys.correct.rawValue)
        userDefaults.set(amount, forKey: Keys.total.rawValue)

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        let today = Date()

        if bestGame.correct < count {
            bestGame = .init(correct: count, total: amount, date: today)
        }
    }
}

struct GameRecord: Codable {
    let correct: Int // кол-во правильных
    let total: Int // всего
    let date: Date // дата
}
