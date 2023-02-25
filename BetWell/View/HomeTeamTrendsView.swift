//
//  HomeTeamTrendsView.swift
//  BetWell
//
//  Created by David Mann on 2/22/23.
//

import SwiftUI

struct HomeTeamTrendsView: View {
    let team: Home
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack(alignment: .center) {
            VStack {
                Text("**Streak**")
                    .underline()
                Text("\(team.standings.streak.length) \(team.standings.streak.kind.rawValue)")
            }
            HStack {
                VStack {
                    Text("**Home**")
                        .underline()
                    HStack(spacing: 2.0) {
                        Text("\(getRecordType(team.standings.records, type: .home)!.wins)")
                        Text("-")
                        Text("\(getRecordType(team.standings.records, type: .home)!.losses)")
                    }
                    
                }
                VStack {
                    Text("**Away**")
                        .underline()
                    HStack(spacing: 2.0) {
                        Text("\(getRecordType(team.standings.records, type: .road)!.wins)")
                        Text("-")
                        Text("\(getRecordType(team.standings.records, type: .road)!.losses)")
                    }
                    
                }
                VStack {
                    Text("**Last 10**")
                        .underline()
                    HStack(spacing: 2.0) {
                        Text("\(getRecordType(team.standings.records, type: .last10)!.wins)")
                        Text("-")
                        Text("\(getRecordType(team.standings.records, type: .home)!.losses)")
                    }
                    
                }
            }
            VStack {
                Text("**Last 10 Avg**")
                    .underline()
                HStack {
                    HStack {
                        VStack {
                            Text("**Pts**")
                                .underline()
                            Text("\(String(format: "%.1f", team.standings.avgPoints))")
                        }
                        VStack {
                            Text("**Ast**")
                                .underline()
                            Text("\(getLast10Data(team.splits, type: .last10, stat: .assists))")
                        }
                        VStack {
                            Text("**Reb**")
                                .underline()
                            Text("\(getLast10Data(team.splits, type: .last10, stat: .rebounds))")
                        }
                        VStack {
                            Text("**3's**")
                                .underline()
                            Text("\(getLast10Data(team.splits, type: .last10, stat: .threesMade))")
                        }
                    }
                }
            }
            VStack() {
                Text("**Out**")
                    .underline()
                Text("\(getInjuries(team.injuries ?? []))")
                    .lineLimit(4)
                    .multilineTextAlignment(.trailing)
                    .minimumScaleFactor(0.01)
            }
        }
        .font(.caption)
        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
        .padding(.leading, 10.0)
        .padding(.trailing, 3.0)
        .frame(width: 200)
    }
    
    
    
    func getLast10Data(_ stats: [Split], type: SplitType, stat: TeamStatType) -> String {
        var string: Double = 0.0
        for i in stats {
//            if i.category == type.rawValue {
//                for j in i.opponents.average {
//                    if j.key == stat.rawValue {
//                        string = j.value
//                    }
//                }
//            }
        }
        return String(format: "%.1f", string)
    }
    
    func getRecordType(_ records: [Record], type: RecordType) -> Record? {
        for i in records {
//            let rec = RecordType(rawValue: i.recordType)
//            if rec == type {
//                return i
//            }
        }
        return nil
    }
    
    func getInjuries(_ injuries: [AwayInjury]) -> String {
        var injuriesLocal = ""
        for i in injuries {
            for j in i.injuries {
                if j.status == .out {
                    let first = i.firstName
                    if let letter = first.first {
                        injuriesLocal.append("\(String(letter)). \(i.lastName), ")
                    }
                }
            }
        }
        return injuriesLocal
    }
}


//struct HomeTeamTrendsView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeTeamTrendsView(team: SampleData.home)
//    }
//}
