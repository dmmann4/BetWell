//
//  PlayerPropsModel.swift
//  BetWell
//
//  Created by David Mann on 2/25/23.
//

import Foundation

// MARK: - NewPlaElement
struct NewPlayerPropOdds: Decodable {
    let sportsbook: String
    let players: [Player]
    
    enum CodingKeys: CodingKey {
        case sportsbook
        case players
    }
}

// MARK: - Player
struct Player: Decodable, Hashable {
   
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.name == rhs.name
    }
    let id = UUID()
    let name: String
    let assists, points: Assists?
    let rebounds: Assists?
    var arrayOfLines: [PropObject] = []
    
    enum CodingKeys: CodingKey {
        case name, assists, points, rebounds
    }
    
    init(name: String, assists: Assists?, points: Assists?, rebounds: Assists?) {
        self.name = name
        self.assists = assists
        self.points = points
        self.rebounds = rebounds
        print("Decoding player props***")
        print(self.rebounds)
        print(self.assists)
        print(self.points)
        if let assists = self.assists {
            arrayOfLines.append(PropObject(propType: PlayerBets.playerAssists, lines: assists))
        }
        if let points = self.points {
            arrayOfLines.append(PropObject(propType: PlayerBets.playerPoints, lines: points))
        }
        if let rebounds = self.rebounds {
            arrayOfLines.append(PropObject(propType: PlayerBets.playerRebounds, lines: rebounds))
        }
        print(arrayOfLines)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.assists = try container.decodeIfPresent(Assists.self, forKey: .assists)
        self.points = try container.decodeIfPresent(Assists.self, forKey: .points)
        self.rebounds = try container.decode(Assists.self, forKey: .rebounds)
        if let assists = self.assists {
            arrayOfLines.append(PropObject(propType: PlayerBets.playerAssists, lines: assists))
        }
        if let points = self.points {
            arrayOfLines.append(PropObject(propType: PlayerBets.playerPoints, lines: points))
        }
        if let rebounds = self.rebounds {
            arrayOfLines.append(PropObject(propType: PlayerBets.playerRebounds, lines: rebounds))
        }
    }
}

struct PropObject: Hashable {
    let propType: PlayerBets
    let lines: Assists
}

enum PlayerBets: String, CaseIterable, Bets {
    case playerPoints = "Points O/U"
    case playerRebounds = "Rebounds O/U"
    case playerAssists = "Assists O/U"
    case playerThrres = "Three's made O/U"
    case playerBlocks = "Blocks O/U"
    case totalPoints10 = "To score 10+"
    case totalPoints15 = "To score 15+"
    case totalPoints20 = "To score 20+"
    case totalPoints25 = "To score 25+"
    case totalPoints30 = "To score 30+"
}

// MARK: - Assists
struct Assists: Codable, Hashable {
    let line: Double
    let over, under: Int
}
