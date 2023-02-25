//
//  NewUpcomingGames.swift
//  BetWell
//
//  Created by David Mann on 2/18/23.
//

import Foundation

// MARK: - NewUpcomingGame
struct NewUpcomingGame: Codable {
    let statsGameID: String
    let time: String
    var venue: String
    var home: Home
    var away: Away
    let oddsEventID: String
    let bookmakers: [Bookmaker]

    enum CodingKeys: String, CodingKey {
        case statsGameID = "statsGameId"
        case time, venue, home, away
        case oddsEventID = "oddsEventId"
        case bookmakers
    }
}

// MARK: - Away
struct Away: Codable {
    let name, alias, id, srID: String
    let reference: String
    let splits: [Split]
    let injuries: [AwayInjury]?
    let standings: AwayStandings

    enum CodingKeys: String, CodingKey {
        case name, alias, id
        case srID = "sr_id"
        case reference, splits, injuries, standings
    }
}

// MARK: - AwayInjury
struct AwayInjury: Codable {
    let id, fullName, firstName, lastName: String
    let position: String
    let primaryPosition: PrimaryPosition
    let jerseyNumber: String
    let nameSuffix: String?
    let srID, reference: String
    let injuries: [InjuryInjury]

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case firstName = "first_name"
        case lastName = "last_name"
        case position
        case primaryPosition = "primary_position"
        case jerseyNumber = "jersey_number"
        case nameSuffix = "name_suffix"
        case srID = "sr_id"
        case reference, injuries
    }
}

// MARK: - InjuryInjury
struct InjuryInjury: Codable {
    let id, comment, desc: String
    let status: Status
    let startDate, updateDate: String

    enum CodingKeys: String, CodingKey {
        case id, comment, desc, status
        case startDate = "start_date"
        case updateDate = "update_date"
    }
}

enum Status: String, Codable {
    case dayToDay = "Day To Day"
    case out = "Out"
    case outForSeason = "Out For Season"
}

enum PrimaryPosition: String, Codable {
    case c = "C"
    case pf = "PF"
    case pg = "PG"
    case sf = "SF"
    case sg = "SG"
}

// MARK: - Split
struct Split: Codable {
    let category: Category
    let ownRecord, opponents: Opponents
    let opponent: Opponent?
    let venue: Venue?
    let dayOfWeek: DayOfWeek?
    let month: Month?

    enum CodingKeys: String, CodingKey {
        case category
        case ownRecord = "own_record"
        case opponents, opponent, venue
        case dayOfWeek = "day_of_week"
        case month
    }
}

enum Category: String, Codable {
    case dayOfWeek = "day_of_week"
    case home = "home"
    case last10 = "last_10"
    case last5 = "last_5"
    case month = "month"
    case opponent = "opponent"
    case over500 = "over_500"
    case road = "road"
    case under500 = "under_500"
    case venue = "venue"
}

enum DayOfWeek: String, Codable {
    case saturday = "Saturday"
}

enum Month: String, Codable {
    case february = "February"
}

// MARK: - Opponent
struct Opponent: Codable {
    let id, name, market, srID: String
    let reference: String

    enum CodingKeys: String, CodingKey {
        case id, name, market
        case srID = "sr_id"
        case reference
    }
}

// MARK: - Opponents
struct Opponents: Codable {
    let total, average: [String: Double]
}

// MARK: - Venue
struct Venue: Codable {
    let id, name: String
    let capacity: Int
    let address, city, state, zip: String
    let country: Country
    let srID: String

    enum CodingKeys: String, CodingKey {
        case id, name, capacity, address, city, state, zip, country
        case srID = "sr_id"
    }
}

enum Country: String, Codable {
    case usa = "USA"
}

// MARK: - AwayStandings
struct AwayStandings: Codable {
    let id, name, record: String
    let winPct, avgPoints, avgPointsAgainst: Double
    let gamesBehind: GamesBehind
    let streak: Streak
    let rank: PurpleRank
    let records: [Record]

    enum CodingKeys: String, CodingKey {
        case id, name, record
        case winPct = "win_pct"
        case avgPoints = "avg_points"
        case avgPointsAgainst = "avg_points_against"
        case gamesBehind = "games_behind"
        case streak, rank, records
    }
}

// MARK: - GamesBehind
struct GamesBehind: Codable {
    let league, conference, division: Double
}

// MARK: - PurpleRank
struct PurpleRank: Codable {
    let divRank, confRank: Int
    let confTiebreak: String?

    enum CodingKeys: String, CodingKey {
        case divRank = "div_rank"
        case confRank = "conf_rank"
        case confTiebreak = "conf_tiebreak"
    }
}

// MARK: - Record
struct Record: Codable {
    let recordType: RecordType
    let wins, losses: Int
    let winPct: Double

    enum CodingKeys: String, CodingKey {
        case recordType = "record_type"
        case wins, losses
        case winPct = "win_pct"
    }
}

enum RecordType: String, Codable, CaseIterable {
    case below500 = "below_500"
    case home = "home"
    case last10 = "last_10"
    case last10_Home = "last_10_home"
    case last10_Road = "last_10_road"
    case over500 = "over_500"
    case road = "road"
}

// MARK: - Streak
struct Streak: Codable {
    let kind: Kind
    let length: Int
}

enum Kind: String, Codable {
    case loss = "loss"
    case win = "win"
}

// MARK: - Bookmaker
struct Bookmaker: Codable {
    let key: BookmakerKey
    let title: Title
    let lastUpdate: String
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
    let lastUpdate: String
    let outcomes: [Outcome]

    enum CodingKeys: String, CodingKey {
        case key
        case lastUpdate = "last_update"
        case outcomes
    }
}

enum MarketKey: String, Codable {
    case h2H = "h2h"
    case spreads = "spreads"
    case totals = "totals"
}

// MARK: - Outcome
struct Outcome: Codable {
    let name: String
    let price: Int
    let point: Double?
}

enum Title: String, Codable {
    case draftKings = "DraftKings"
    case fanDuel = "FanDuel"
}

// MARK: - Home
struct Home: Codable {
    let name, alias, id, srID: String
    let reference: String
    let splits: [Split]
    let injuries: [AwayInjury]?
    let standings: HomeStandings

    enum CodingKeys: String, CodingKey {
        case name, alias, id
        case srID = "sr_id"
        case reference, splits, injuries, standings
    }
}

// MARK: - HomeStandings
struct HomeStandings: Codable {
    let id, name, record: String
    let winPct, avgPoints, avgPointsAgainst: Double
    let gamesBehind: GamesBehind
    let streak: Streak
    let rank: FluffyRank
    let records: [Record]

    enum CodingKeys: String, CodingKey {
        case id, name, record
        case winPct = "win_pct"
        case avgPoints = "avg_points"
        case avgPointsAgainst = "avg_points_against"
        case gamesBehind = "games_behind"
        case streak, rank, records
    }
}

// MARK: - FluffyRank
struct FluffyRank: Codable {
    let divRank, confRank: Int

    enum CodingKeys: String, CodingKey {
        case divRank = "div_rank"
        case confRank = "conf_rank"
    }
}

typealias NewUpcomingGames = [NewUpcomingGame]
