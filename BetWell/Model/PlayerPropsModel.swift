//
//  PlayerPropsModel.swift
//  BetWell
//
//  Created by David Mann on 2/25/23.
//

import Foundation

// MARK: - NewPlaElement
struct NewPlayerPropOdds: Codable {
    let sportsbook: String
    let players: [Player]
    
    enum CodingKeys: CodingKey {
        case sportsbook
        case players
    }
}

// MARK: - Player
struct Player: Codable, Hashable {
    let name: String
    let assists, points: Assists?
    let rebounds: Assists
    var arrayOfLines: [Assists]
    
    init(name: String, assists: Assists?, points: Assists?, rebounds: Assists) {
        self.name = name
        self.assists = assists
        self.points = points
        self.rebounds = rebounds
        if let assists = self.assists, let points = self.points {
            self.arrayOfLines = [self.rebounds, assists, points]
        } else {
            self.arrayOfLines = [self.rebounds]
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.assists = try container.decodeIfPresent(Assists.self, forKey: .assists)
        self.points = try container.decodeIfPresent(Assists.self, forKey: .points)
        self.rebounds = try container.decode(Assists.self, forKey: .rebounds)
        if let assists = self.assists, let points = self.points {
            self.arrayOfLines = [self.rebounds, assists, points]
        } else {
            self.arrayOfLines = [self.rebounds]
        }
    }
}

// MARK: - Assists
struct Assists: Codable, Hashable {
    let line: Double
    let over, under: Int
}
