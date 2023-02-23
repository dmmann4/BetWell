//
//  AwayTrendsView.swift
//  BetWell
//
//  Created by David Mann on 2/22/23.
//

import SwiftUI

struct AwayTeamTrendsView: View {
    let team: Away
    var body: some View {
        VStack(alignment: .leading) {
            Text("Streak: \(team.standings.streak.length) \(team.standings.streak.kind)")
            Text("Home: \(getRecordType(team.standings.records, type: .home)!.wins)-\(getRecordType(team.standings.records, type: .home)!.losses)")
            Text("Away: \(getRecordType(team.standings.records, type: .road)!.wins)-\(getRecordType(team.standings.records, type: .road)!.losses)")
            Text("Last 10: \(getRecordType(team.standings.records, type: .last10)!.wins)-\(getRecordType(team.standings.records, type: .home)!.losses)")
            Text("Last 10 Avg: Pts: \(String(format: "%.1f", team.standings.avgPoints)) | Ast: \(getLast10Data(team.splits, type: .last10, stat: .assists)) | Reb: \(getLast10Data(team.splits, type: .last10, stat: .rebounds)) | Team 3's: \(getLast10Data(team.splits, type: .last10, stat: .threesMade))")
            Text("Out: \(getInjuries(team.injuries ?? []))")
        }
        .font(.caption)
        .padding(.leading, 10.0)
        .padding(.trailing, 3.0)
    }
    
    
    
    func getLast10Data(_ stats: [Split], type: SplitType, stat: TeamStatType) -> String {
        var string: Double = 0.0
        for i in stats {
            if i.category == type.rawValue {
                for j in i.opponents.average {
                    if j.key == stat.rawValue {
                        string = j.value
                    }
                }
            }
        }
        return String(format: "%.1f", string)
    }
    
    func getRecordType(_ records: [Record], type: RecordType) -> Record? {
        for i in records {
            let rec = RecordType(rawValue: i.recordType)
            if rec == type {
                return i
            }
        }
        return nil
    }
    
    func getInjuries(_ injuries: [AwayInjury]) -> String {
        var injuriesLocal = ""
        for i in injuries {
            for j in i.injuries {
                if j.status == .out {
                    injuriesLocal.append("\(i.fullName), ")
                }
            }
        }
        return injuriesLocal
    }
}

struct AwayTeamTrendsView_Previews: PreviewProvider {
    static var previews: some View {
        AwayTeamTrendsView(team: SampleData.away)
    }
}
