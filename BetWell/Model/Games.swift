//
//  Games.swift
//  BetWell
//
//  Created by David Mann on 2/3/23.
//

import Foundation

struct MyOwnGamesModel: Codable {
    let statsGameId: Int
    let home, away: Teams
    let oddsEventId: String?
    let bookmakers: [Books]?
}

struct Teams: Codable {
    let id: Int
    let name: String
    let nickname: String
    let code: String
    let logo: String
}

struct Books: Codable {
    let key: String
    let title: String
    let last_update: String
    let markets: [BookValues]
}

struct BookValues: Codable {
    let key: String
    let last_update: String
    let outcomes: [Odds]
}

struct Odds: Codable {
    let name: String
    let price: Int
}

struct PlayerPropOdds: Codable {
    let sportsbook: String
    let players: [NBAPlayers]
}

struct NBAPlayers: Codable {
    let name: String
    let assists: [Lines]
}

struct Lines: Codable {
    let line: Float
    let over: Float
    let under: Float
}

import Foundation

// MARK: - UpcomingGame
struct UpcomingGame: Codable {
    let statsGameID: Int
    let home, away: Team
    let oddsEventID: String?
    let bookmakers: [Bookmaker]?

    enum CodingKeys: String, CodingKey {
        case statsGameID = "statsGameId"
        case home, away
        case oddsEventID = "oddsEventId"
        case bookmakers
    }
}

// MARK: - Away
struct Team: Codable {
    let id: Int
    let name, nickname, code: String
    let logo: String
    let standings: Standings
}

// MARK: - Standings
struct Standings: Codable {
    let conference, division: Conference
    let win, loss: Loss
    let gamesBack: String?
    let streak: Int
    let winStreak: Bool
}

// MARK: - Conference
struct Conference: Codable {
    let name: String
    let rank, win, loss: Int
    let gamesBehind: String?
}

// MARK: - Loss
struct Loss: Codable {
    let home, away, total: Int
    let percentage: String
    let lastTen: Int
}

// MARK: - Bookmaker
struct Bookmaker: Codable {
    let key: BookmakerKey
    let title: Title
    let lastUpdate: Date
    let markets: [Market]

    enum CodingKeys: String, CodingKey {
        case key, title
        case lastUpdate = "last_update"
        case markets
    }
}

enum BookmakerKey: String, Codable {
    case draftkings = "draftkings"
    case fanduel = "fanduel"
}

// MARK: - Market
struct Market: Codable {
    let key: MarketKey
    let lastUpdate: Date
    let outcomes: [Outcome]

    enum CodingKeys: String, CodingKey {
        case key
        case lastUpdate = "last_update"
        case outcomes
    }
}

enum MarketKey: String, Codable {
    case h2H = "h2h"
}

// MARK: - Outcome
struct Outcome: Codable {
    let name: String
    let price: Int
}

enum Title: String, Codable {
    case draftKings = "DraftKings"
    case fanDuel = "FanDuel"
}

typealias UpcomingGames = [UpcomingGame]
