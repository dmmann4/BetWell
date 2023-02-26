//
//  Networking.swift
//  BetWell
//
//  Created by David Mann on 2/3/23.
//

import Foundation
import Combine

class Networking {
    func fetchTodaysGames(completion: @escaping (Result<[NewUpcomingGame], NetworkError>) -> Void) {
        var request = URLRequest(url: URL(string: "https://betwellapi.onrender.com/api/upcoming-games")!)
        let username = "dmmanntula4"
        let password = "D4822T201484!em%"
        let loginString = "\(username):\(password)"

        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.transportError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(.failure(.serverError(statusCode: response.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
//            let str = String(decoding: data, as: UTF8.self)
//            print("got data - \(str)")
            do {
                let games = try JSONDecoder().decode([NewUpcomingGame].self, from: data)
//                print("upcomingGames = \(games)")
                
//                print("home - \(games[0].home)")
//
//                print("away - \(games[0].away)")
//
//                print("books - \(games[0].bookmakers)")
                
                completion(.success(games))
            } catch(let error) {
                print("decoding error - \(error)")
                completion(.failure(.decodingError(error)))
            }
        }.resume()
    }
    
    func fetchPlayerPropsGames(_ gameId: String, completion: @escaping (Result<[NewUpcomingGame], NetworkError>) -> Void) {
//        print("game id - \(gameId)")
        var request = URLRequest(url: URL(string: "https://betwellapi.onrender.com/api/player-props/\(SampleData.oddsID)")!)
        let username = "dmmanntula4"
        let password = "D4822T201484!em%"
        let loginString = "\(username):\(password)"

        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.transportError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(.failure(.serverError(statusCode: response.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
//            let str = String(decoding: data, as: UTF8.self)
//            print("got data player props - \(str)")
            do {
                let games = try JSONDecoder().decode([NewUpcomingGame].self, from: data)
                print("player props - \(games)")
                completion(.success(games))
            } catch(let error) {
                print("decoding error - \(error)")
                completion(.failure(.decodingError(error)))
            }
        }.resume()
    }
}

enum NetworkError: Error {
    case transportError(Error)
    case serverError(statusCode: Int)
    case noData
    case decodingError(Error)
    case encodingError(Error)
}

