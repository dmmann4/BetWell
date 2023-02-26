//
//  RecordTime.swift
//  BetWell
//
//  Created by David Mann on 2/18/23.
//

import Foundation

enum SplitType: String, CaseIterable {
    case over500 = "over_500"
    case road = "road"
    case home = "home"
    case venue = "venue"
    case last10 = "last_10"
    case dayOfWeek = "day_of_week"
    case under500 = "under_500"
    case opponent = "opponent"
}

enum TeamStatType: String, CaseIterable {
    case rebounds = "rebounds"
    case threesMade = "three_points_made"
    case assists = "assists"
}

let last5GamesHome: [LastFiveGames] =  [
    LastFiveGames(date: "12/14", opponent: "CHA", score: "120-114", result: "W"),
    LastFiveGames(date: "12/16", opponent: "BOS", score: "123-134", result: "L"),
    LastFiveGames(date: "12/20", opponent: "LAL", score: "113-109", result: "W"),
    LastFiveGames(date: "12/22", opponent: "GSW", score: "101-119", result: "L"),
    LastFiveGames(date: "12/25", opponent: "NYK", score: "113-114", result: "L")
]
let last5GamesVisitor: [LastFiveGames] =  [
    LastFiveGames(date: "12/15", opponent: "MIA", score: "122-130", result: "L"),
    LastFiveGames(date: "12/16", opponent: "MEM", score: "101-105", result: "L"),
    LastFiveGames(date: "12/19", opponent: "IND", score: "109-107", result: "W"),
    LastFiveGames(date: "12/22", opponent: "CLE", score: "108-115", result: "L"),
    LastFiveGames(date: "12/26", opponent: "BRK", score: "98-94", result: "W")
]

enum TeamImage: String {
    case ATL = "atlanta-hawks"
    case BOS = "boston-celtics"
    case MIL = "milwaukee-bucks"
    case MIN = "minnesota-timberwolves"
    case LAC = "la-clippers"
    case WAS = "washington-wizards"
    case CHI = "chicago-bulls"
    case PHX = "phoenix-suns"
}
