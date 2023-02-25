//
//  RecordTime.swift
//  BetWell
//
//  Created by David Mann on 2/18/23.
//

import Foundation

//enum RecordType: String, CaseIterable {
//    case below500 = "below_500"
//    case home = "home"
//    case last10 = "last_10"
//    case last10Home = "last_10_home"
//    case last10Road = "last_10_road"
//    case over500 = "over_500"
//    case road = "road"
//}

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

//"games_played": 31,
//"minutes": 7465,
//"field_goals_made": 1288,
//"field_goals_att": 2726,
//"field_goals_pct": 0.472,
//"two_points_made": 838,
//"two_points_att": 1524,
//"two_points_pct": 0.55,
//"three_points_made": 450,
//"three_points_att": 1202,
//"three_points_pct": 0.374,
//"blocked_att": 102,
//"free_throws_made": 517,
//"free_throws_att": 715,
//"free_throws_pct": 0.723,
//"offensive_rebounds": 331,
//"defensive_rebounds": 1120,
//"rebounds": 1451,
//"assists": 763,
//"turnovers": 427,
//"assists_turnover_ratio": 1.79,
//"steals": 204,
//"blocks": 134,
//"personal_fouls": 551,
//"tech_fouls": 35,
//"points": 3543,
//"fast_break_pts": 400,
//"flagrant_fouls": 3,
//"points_off_turnovers": 414,
//"second_chance_pts": 449,
//"ejections": 0,
//"foulouts": 3,
//"points_in_paint": 1368,
//"efficiency": 4032,
//"true_shooting_att": 3040.6,
//"true_shooting_pct": 0.583,
//"points_in_paint_made": 684,
//"points_in_paint_att": 1159,
//"points_in_paint_pct": 0.59,
//"effective_fg_pct": 0.555,
//"bench_points": 1021,
//"fouls_drawn": 572,
//"offensive_fouls": 66,
//"team_tech_fouls": 19,
//"defensive_assists": 0,
//"fast_break_att": 259,
//"fast_break_made": 140,
//"fast_break_pct": 0.541,
//"technical_other": 0,
//"coach_ejections": 0,
//"points_against": 3470,
//"team_defensive_rebounds": 72,
//"team_offensive_rebounds": 219,
//"second_chance_att": 335,
//"second_chance_made": 174,
//"second_chance_pct": 0.519,
//"coach_tech_fouls": 3,
//"team_fouls": 22,
//"total_rebounds": 1742,
//"total_fouls": 573
//},
//"average": {
//"fast_break_pts": 12.9,
//"points_off_turnovers": 13.35,
//"second_chance_pts": 14.48,
//"minutes": 240.8,
//"points": 114.3,
//"off_rebounds": 10.68,
//"def_rebounds": 36.13,
//"rebounds": 46.81,
//"assists": 24.6,
//"steals": 6.58,
//"blocks": 4.32,
//"turnovers": 13.77,
//"personal_fouls": 17.77,
//"flagrant_fouls": 0.1,
//"blocked_att": 3.29,
//"field_goals_made": 41.55,
//"field_goals_att": 87.94,
//"three_points_made": 14.52,
//"three_points_att": 38.77,
//"free_throws_made": 16.68,
//"free_throws_att": 23.06,
//"two_points_made": 27.03,
//"two_points_att": 49.16,
//"points_in_paint": 44.13,
//"efficiency": 130.06,
//"true_shooting_att": 98.08,
//"points_in_paint_att": 37.39,
//"points_in_paint_made": 22.06,
//"bench_points": 32.94,
//"fouls_drawn": 18.45,
//"offensive_fouls": 2.13,
//"fast_break_att": 8.35,
//"fast_break_made": 4.52,
//"second_chance_att": 10.81,
//"second_chance_made": 5.61

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
