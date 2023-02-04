//
//  Networking.swift
//  BetWell
//
//  Created by David Mann on 2/3/23.
//

import Foundation
import Combine

class Networking {
    func fetchTodaysGames(completion: @escaping (Result<[Response], NetworkError>) -> Void) {
        var request = URLRequest(url: URL(string: "https://api-nba-v1.p.rapidapi.com/games?date=2022-02-12")!)
        request.allHTTPHeaderFields = [
            "X-RapidAPI-Key": "c9a3999ce2msh1deb5d6547573bep1ae92ejsn3a046fff7ce0",
            "X-RapidAPI-Host": "api-nba-v1.p.rapidapi.com"
        ]
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
            
            do {
                let games = try JSONDecoder().decode(GamesModel.self, from: data)
                completion(.success(games.response))
            } catch {
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

