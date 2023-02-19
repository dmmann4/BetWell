//
//  TeamDataListView.swift
//  BetWell
//
//  Created by David Mann on 2/10/23.
//

import Foundation
import SwiftUI

struct TeamDataListView: View {
    
    var home: Home
    var away: Away
    var venue: String

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    VStack {
                        HomeTeamDetailHeaderView(team: home)
                    }
                    .padding()
                    VStack(alignment: .center) {
                       Text(venue)
                            .font(.caption)
                       Text("Officials:")
                            .font(.caption)
                       Text("G. Brady, H. Smith, L. Jones")
                            .font(.caption)
                    }
                    VStack {
                        AwayTeamDetailHeaderView(team: away)
                    }
                }
                HStack {
                    HomeTeamTrendsView(team: home)
                    Spacer()
                    AwayTeamTrendsView(team: away)
                }
                MatchupDetailView(home: home, away: away)
                Spacer()
            }
        }.onAppear() {
          print("home \(home)")
          print("away \(away)")
        }
        .navigationBarTitle(Text(""), displayMode: .inline)
    }
}

struct TeamDataListView_Previews: PreviewProvider {
    static var previews: some View {
        TeamDataListView(home: SampleData.home, away: SampleData.away, venue: "TD Garden")
    }
}

struct AwayTeamTrendsView: View {
    let team: Away
    var body: some View {
        VStack(alignment: .leading) {
            Text("Streak: \(team.standings.streak.length) \(team.standings.streak.kind)")
            Text("Home: \(getRecordType(team.standings.records, type: .home)!.wins)-\(getRecordType(team.standings.records, type: .home)!.losses)")
            Text("Away: \(getRecordType(team.standings.records, type: .road)!.wins)-\(getRecordType(team.standings.records, type: .road)!.losses)")
            Text("Last 10: \(getRecordType(team.standings.records, type: .last10)!.wins)-\(getRecordType(team.standings.records, type: .home)!.losses)")
            Text("Last 10 Avg: Pts: \(team.standings.avgPoints) | Ast: \(getLast10Data(team.splits, type: .last10, stat: .assists)) | Reb: \(getLast10Data(team.splits, type: .last10, stat: .rebounds)) | Team 3's: \(getLast10Data(team.splits, type: .last10, stat: .threesMade))")
            Text("Out: \(getInjuries(team.injuries ?? []))")
        }
        .font(.caption)
        .padding(.leading, 10.0)
        .padding(.trailing, 3.0)
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
    
    func getLast10Data(_ stats: [Split], type: SplitType, stat: TeamStatType) -> Double {
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
        return string
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

struct HomeTeamTrendsView: View {
    let team: Home
    var body: some View {
        VStack(alignment: .leading) {
            Text("Streak: \(team.standings.streak.length) \(team.standings.streak.kind)")
            Text("Home: \(getRecordType(team.standings.records, type: .home)!.wins)-\(getRecordType(team.standings.records, type: .home)!.losses)")
            Text("Away: \(getRecordType(team.standings.records, type: .road)!.wins)-\(getRecordType(team.standings.records, type: .road)!.losses)")
            Text("Last 10: \(getRecordType(team.standings.records, type: .last10)!.wins)-\(getRecordType(team.standings.records, type: .home)!.losses)")
            Text("Last 10 Avg: Pts: \(team.standings.avgPoints) | Ast: \(getLast10Data(team.splits, type: .last10, stat: .assists)) | Reb: \(getLast10Data(team.splits, type: .last10, stat: .rebounds)) | Team 3's: \(getLast10Data(team.splits, type: .last10, stat: .threesMade))")
            Text("Out: \(getInjuries(team.injuries))")
        }
        .font(.caption)
        .padding(.leading, 10.0)
        .padding(.trailing, 3.0)
    }
    
    
    
    func getLast10Data(_ stats: [Split], type: SplitType, stat: TeamStatType) -> Double {
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
        return string
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



struct HomeTeamDetailHeaderView: View {
    let team: Home
    var body: some View {
        Image(team.alias)
            .resizable()
            .scaledToFill()
            .frame(width: 44, height: 44)
            .background(Color.gray)
            .clipShape(Circle())
        Text(team.alias)
            .fontWeight(.bold)
        Text("\(team.standings.record)-\(team.standings.winPct)(\(team.standings.rank.confRank)th in \(team.standings.rank.divRank))")
            .font(.caption2)
    }
}

struct AwayTeamDetailHeaderView: View {
    let team: Away
    var body: some View {
        Image(team.alias)
            .resizable()
            .scaledToFill()
            .frame(width: 44, height: 44)
            .background(Color.gray)
            .clipShape(Circle())
        Text(team.alias)
            .fontWeight(.bold)
        Text("\(team.standings.record)-\(team.standings.winPct)(\(team.standings.rank.confRank)th in \(team.standings.rank.divRank))")
            .font(.caption2)
    }
}
