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
}

// MARK: - Player
struct Player: Codable {
    let name: String
    let assists, points: Assists?
    let rebounds: Assists
}

// MARK: - Assists
struct Assists: Codable {
    let line: Double
    let over, under: Int
}
