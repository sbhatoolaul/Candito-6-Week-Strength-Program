//
//  Exercise.swift
//  Candito 6 Week Program
//
//  Created by Shivam Bhatoolaul on 2023-03-29.
//

import SwiftUI


class Load: Identifiable {
    var id: UUID = UUID()
    var weight: Int
    var reps: String
    var multiplier: Double
    var adder: Int = 0
    var mRoundAdder:Double = 0
    var comments:String = ""
    
    init(id: UUID = UUID(), weight: Int, reps: String, multiplier: Double, adder: Int = 0, mRoundAdder: Double=0.0, comments: String="") {
        self.id = id
        self.weight = weight
        self.reps = reps
        self.multiplier = multiplier
        self.adder = adder
        self.mRoundAdder = mRoundAdder
        self.comments = comments
    }
    
    func roundUpToFive (value: Int) -> Int {
        var newValue = value
        while newValue % 5 != 0 { newValue += 1}
        return newValue
    }
    
    func roundDownToFive (value: Int) -> Int {
        var newValue = value
        while newValue % 5 != 0 { newValue -= 1}
        return newValue
    }
    
    func MROUNDToFive(value: Double) -> Int{
        // From MROUND Microsoft Documentation: https://support.microsoft.com/en-us/office/mround-function-c299c3b0-15a5-426d-aa4b-d2d5b3baf427
        
        if value.truncatingRemainder(dividingBy: 5.0) >= 2.5 { return roundUpToFive(value: Int(value)) + self.adder }
        return roundDownToFive(value: Int(value)) + self.adder
    }
    
    func updateWeight(weight: Int){
        self.weight = MROUNDToFive(value: (Double(weight) * multiplier) + self.mRoundAdder)
    }
}

class Exercise: Identifiable {
    var id: UUID = UUID()
    let name: String
    var warmup: Bool
    var loads: [Load]
    
    init(id: UUID = UUID(), name: String, warmup: Bool=true, loads: [Load]) {
        self.id = id
        self.name = name
        self.warmup = warmup
        self.loads = loads
    }
}

class Session: Identifiable {
    var id: UUID = UUID()
    var name: String = ""
    var exercises: [Exercise]
    init(id: UUID = UUID(), name: String = "", exercises: [Exercise]) {
        self.id = id
        self.name = name
        self.exercises = exercises
    }
}

class Week: Identifiable {
    var id: UUID = UUID()
    var number: Int
    var subtitle: String = ""
    var sessions: [Session]
    init(id: UUID = UUID(), number: Int, subtitle: String = "", sessions: [Session]) {
        self.id = id
        self.number = number
        self.subtitle = subtitle
        self.sessions = sessions
    }
    
    func updateWeights(weights: [Int]){
        
        var weight: Int
        
        for session in self.sessions {
            for exercise in session.exercises {
                weight = -1
                
                // weights[0] = new Bench PR, weights[1] = new Squat PR, weights[2] = new Deadlift PR
                if exercise.name == "Bench Press" { weight = weights[0] }
                if exercise.name == "Squat" { weight = weights[1] }
                if exercise.name == "Deadlift" { weight = weights[2] }
                
                if weight != -1 {
                    for load in exercise.loads {
                        load.updateWeight(weight: weight)
                    }
                }
            }
        }
    }
}


class InitialData {
    var w1: Week
    var w2: Week
    var w3: Week
    var w4: Week
    var w5: Week
    var weeks: [Week]
    
    
    init() {
        // Creating the InitialData for the Weeks - Week 1 --------------------------------------------------------
        let w1s1 = Session(name: "Monday", exercises: [Exercise(name: "Squat", loads: [Load(weight: 0, reps: "6", multiplier: 0.8),
                                                                                       Load(weight: 0, reps: "6", multiplier: 0.8),
                                                                                       Load(weight: 0, reps: "6", multiplier: 0.8),
                                                                                       Load(weight: 0, reps: "6", multiplier: 0.8),
                                                                                      ]),
                                                       Exercise(name: "Deadlift", loads: [Load(weight: 0, reps: "6", multiplier: 0.8),
                                                                                          Load(weight: 0, reps: "6", multiplier: 0.8),
                                                                                         ]),
                                                       
                                                       Exercise(name: "Optional Exercise 1", loads: [Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                    ]),
                                                       Exercise(name: "Optional Exercise 2", loads: [Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                    ]),
        ])
        let w1s2 = Session(name: "Tuesday", exercises: [Exercise(name: "Bench Press", loads: [Load(weight: 0, reps: "10", multiplier: 0.5),
                                                                                              Load(weight: 0, reps: "10", multiplier: 0.675),
                                                                                              Load(weight: 0, reps: "8", multiplier: 0.75),
                                                                                              Load(weight: 0, reps: "6", multiplier: 0.775),
                                                                                             ]),
                                                        
                                                        Exercise(name: "Horizontal Pull", loads: [Load(weight: 0, reps: "10", multiplier: 0),
                                                                                                  Load(weight: 0, reps: "10", multiplier: 0),
                                                                                                  Load(weight: 0, reps: "8", multiplier: 0),
                                                                                                  Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                 ]),
                                                        Exercise(name: "Shoulder Exercise", loads: [Load(weight: 0, reps: "12", multiplier: 0),
                                                                                                    Load(weight: 0, reps: "12", multiplier: 0),
                                                                                                    Load(weight: 0, reps: "10", multiplier: 0),
                                                                                                    Load(weight: 0, reps: "8", multiplier: 0),
                                                                                                   ]),
                                                        Exercise(name: "Vertical Pull", loads: [Load(weight: 0, reps: "12", multiplier: 0),
                                                                                                Load(weight: 0, reps: "12", multiplier: 0),
                                                                                                Load(weight: 0, reps: "10", multiplier: 0),
                                                                                                Load(weight: 0, reps: "8", multiplier: 0),
                                                                                               ]),
                                                        Exercise(name: "Optional Exercise 1", loads: [Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                      Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                      Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                     ]),
                                                        Exercise(name: "Optional Exercise 2", loads: [Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                      Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                      Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                     ]),
                                                        
                                                        
        ])
        let w1s3 = Session(name: "Thursday", exercises: [Exercise(name: "Bench Press", loads: [Load(weight: 0, reps: "10", multiplier: 0.5),
                                                                                               Load(weight: 0, reps: "10", multiplier: 0.675),
                                                                                               Load(weight: 0, reps: "8", multiplier: 0.75),
                                                                                               Load(weight: 0, reps: "6", multiplier: 0.775),
                                                                                              ]),
                                                         Exercise(name: "Horizontal Pull", loads: [Load(weight: 0, reps: "10", multiplier: 0),
                                                                                                   Load(weight: 0, reps: "10", multiplier: 0),
                                                                                                   Load(weight: 0, reps: "8", multiplier: 0),
                                                                                                   Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                  ]),
                                                         Exercise(name: "Shoulder Exercise", loads: [Load(weight: 0, reps: "12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "10", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "8", multiplier: 0),
                                                                                                    ]),
                                                         Exercise(name: "Vertical Pull", loads: [Load(weight: 0, reps: "12", multiplier: 0),
                                                                                                 Load(weight: 0, reps: "12", multiplier: 0),
                                                                                                 Load(weight: 0, reps: "10", multiplier: 0),
                                                                                                 Load(weight: 0, reps: "8", multiplier: 0),
                                                                                                ]),
                                                         Exercise(name: "Optional Exercise 1", loads: [Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                       Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                       Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                      ]),
                                                         Exercise(name: "Optional Exercise 2", loads: [Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                       Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                       Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                      ]),
        ])
        
        let w1s4 = Session(name: "Friday", exercises: [Exercise(name: "Squat", loads: [Load(weight: 0, reps: "8", multiplier: 0.7),
                                                                                       Load(weight: 0, reps: "8", multiplier: 0.7),
                                                                                       Load(weight: 0, reps: "8", multiplier: 0.7),
                                                                                       Load(weight: 0, reps: "8", multiplier: 0.7),
                                                                                      ]),
                                                       Exercise(name: "Deadlift", loads: [Load(weight: 0, reps: "8", multiplier: 0.7),
                                                                                          Load(weight: 0, reps: "8", multiplier: 0.7),
                                                                                         ]),
                                                       Exercise(name: "Optional Exercise 1", loads: [Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                    ]),
                                                       Exercise(name: "Optional Exercise 2", loads: [Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                    ]),
                                                       
                                                       
        ])
        let w1s5 = Session(name: "Saturday", exercises: [Exercise(name: "Bench Press", loads: [Load(weight: 0, reps: "MR", multiplier: 0.8),
                                                                                              ]),
                                                         Exercise(name: "Horizontal Pull", loads: [Load(weight: 0, reps: "10", multiplier: 0),
                                                                                                   Load(weight: 0, reps: "10", multiplier: 0),
                                                                                                   Load(weight: 0, reps: "8", multiplier: 0),
                                                                                                   Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                  ]),
                                                         Exercise(name: "Shoulder Exercise", loads: [Load(weight: 0, reps: "12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "10", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "8", multiplier: 0),
                                                                                                    ]),
                                                         Exercise(name: "Vertical Pull", loads: [Load(weight: 0, reps: "12", multiplier: 0),
                                                                                                 Load(weight: 0, reps: "12", multiplier: 0),
                                                                                                 Load(weight: 0, reps: "10", multiplier: 0),
                                                                                                 Load(weight: 0, reps: "8", multiplier: 0),
                                                                                                ]),
                                                         Exercise(name: "Optional Exercise 1", loads: [Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                       Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                       Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                      ]),
                                                         Exercise(name: "Optional Exercise 2", loads: [Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                       Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                       Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                      ]),
        ])
        
        self.w1 = Week(number: 1, subtitle: "Muscular Conditioning (w/ Moderate Difficulty)", sessions: [w1s1, w1s2, w1s3, w1s4, w1s5])
        
        // Week 2 -------------------------------------------------------------------------------------------------
        let w2s1 = Session(name: "Monday", exercises: [Exercise(name: "Squat", loads: [Load(weight: 0, reps: "MR10", multiplier: 0.8, comments: "\nExtra Volume Squats - Add 5 lbs, then perform 5 sets x 3 reps each set with 60 seconds rest between sets. \n\nNote - If you were not able to complete a minimum of 8 reps on the MR10 set, reduce max entered by 2.5% moving forward. \n\nStill complete the 5 sets of 3 reps regardless even if you do perform less than 8 reps on the MR10 set."),
                                                                                       
                                                                                      ]),
                                                       Exercise(name: "Deadlift Variation", loads: [Load(weight: 0, reps: "8", multiplier: 0),
                                                                                                    Load(weight: 0, reps: "8", multiplier: 0),
                                                                                                    Load(weight: 0, reps: "8", multiplier: 0),
                                                                                                   ]),
                                                       Exercise(name: "Optional Exercise 1", loads: [Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                    ]),
                                                       Exercise(name: "Optional Exercise 2", loads: [Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                    ]),
        ])
        let w2s2 = Session(name: "Tuesday", exercises: [Exercise(name: "Bench Press", loads: [Load(weight: 0, reps: "10", multiplier: 0.725),
                                                                                              Load(weight: 0, reps: "8", multiplier: 0.775),
                                                                                              Load(weight: 0, reps: "6-8", multiplier: 0.8, adder:5),
                                                                                             ]),
                                                        Exercise(name: "Horizontal Pull", loads: [Load(weight: 0, reps: "10", multiplier: 0),
                                                                                                  Load(weight: 0, reps: "10", multiplier: 0),
                                                                                                  Load(weight: 0, reps: "8", multiplier: 0),
                                                                                                 ]),
                                                        Exercise(name: "Shoulder Exercise", loads: [Load(weight: 0, reps: "10", multiplier: 0),
                                                                                                    Load(weight: 0, reps: "8", multiplier: 0),
                                                                                                    Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                   ]),
                                                        Exercise(name: "Vertical Pull", loads: [Load(weight: 0, reps: "10", multiplier: 0),
                                                                                                Load(weight: 0, reps: "8", multiplier: 0),
                                                                                                Load(weight: 0, reps: "6", multiplier: 0),
                                                                                               ]),
                                                        Exercise(name: "Optional Exercise 1", loads: [Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                      Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                      Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                     ]),
                                                        Exercise(name: "Optional Exercise 2", loads: [Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                      Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                      Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                     ]),
        ])
        let w2s3 = Session(name: "Thursday", exercises: [Exercise(name: "Squat", loads: [Load(weight: 0, reps: "MR10", multiplier: 0.8, adder: 5, comments: "\nBack Off Squats - Reduce weight by 10 lbs or 5 kg if using kg plates. Then proceed with the following: \n\nIf you were able to complete 10 reps on the MR10 set, perform 10 sets of 3 reps per set, with 60 seconds rest between sets.\n\nIf you completed 8-9 reps on the MR10 set, perform 8 sets of 3 reps per set, with 60 seconds rest between sets.\n\nIf you completed 7 reps on the MR 10 set, perform 5 sets of 3 reps per set, with 60 seconds rest between sets.\n\nIf you completed less than 7 reps, skip back off sets entirely and reduce your entered 1 rep max by at least 2.5% for following weeks."),
                                                                                        ]),
                                                         Exercise(name: "Deadlift Variation", loads: [Load(weight: 0, reps: "8", multiplier: 0),
                                                                                                      Load(weight: 0, reps: "8", multiplier: 0),
                                                                                                      Load(weight: 0, reps: "8", multiplier: 0),
                                                                                                     ]),
                                                         Exercise(name: "Optional Exercise 1", loads: [Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                       Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                       Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                      ]),
                                                         Exercise(name: "Optional Exercise 2", loads: [Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                       Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                       Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                      ]),
        ])
        let w2s4 = Session(name: "Friday", exercises: [Exercise(name: "Bench Press", loads: [Load(weight: 0, reps: "10", multiplier: 0.725),
                                                                                             Load(weight: 0, reps: "8", multiplier: 0.775),
                                                                                             Load(weight: 0, reps: "6-8", multiplier: 0.8, adder:5),
                                                                                            ]),
                                                       Exercise(name: "Horizontal Pull", loads: [Load(weight: 0, reps: "10", multiplier: 0),
                                                                                                 Load(weight: 0, reps: "10", multiplier: 0),
                                                                                                 Load(weight: 0, reps: "8", multiplier: 0),
                                                                                                ]),
                                                       Exercise(name: "Shoulder Exercise", loads: [Load(weight: 0, reps: "10", multiplier: 0),
                                                                                                   Load(weight: 0, reps: "8", multiplier: 0),
                                                                                                   Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                  ]),
                                                       Exercise(name: "Vertical Pull", loads: [Load(weight: 0, reps: "10", multiplier: 0),
                                                                                               Load(weight: 0, reps: "8", multiplier: 0),
                                                                                               Load(weight: 0, reps: "6", multiplier: 0),
                                                                                              ]),
                                                       Exercise(name: "Optional Exercise 1", loads: [Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                    ]),
                                                       Exercise(name: "Optional Exercise 2", loads: [Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                    ]),
        ])
        let w2s5 = Session(name: "Saturday", exercises: [Exercise(name: "Bench Press", loads: [Load(weight: 0, reps: "MR", multiplier: 0.8, adder: -5),
                                                                                              ]),
                                                         Exercise(name: "Horizontal Pull", loads: [Load(weight: 0, reps: "10", multiplier: 0),
                                                                                                   Load(weight: 0, reps: "10", multiplier: 0),
                                                                                                   Load(weight: 0, reps: "8", multiplier: 0),
                                                                                                  ]),
                                                         Exercise(name: "Shoulder Exercise", loads: [Load(weight: 0, reps: "10", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "8", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                    ]),
                                                         Exercise(name: "Vertical Pull", loads: [Load(weight: 0, reps: "10", multiplier: 0),
                                                                                                 Load(weight: 0, reps: "8", multiplier: 0),
                                                                                                 Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                ]),
                                                         Exercise(name: "Optional Exercise 1", loads: [Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                       Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                       Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                      ]),
                                                         Exercise(name: "Optional Exercise 2", loads: [Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                       Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                       Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                      ]),
        ])
        
        self.w2 = Week(number: 2, subtitle: "Muscular Conditioning & Hypertrophy (w/ Higher Difficulty)", sessions: [w2s1, w2s2, w2s3, w2s4, w2s5])
        
        // Week 3 -------------------------------------------------------------------------------------------------
        let w3s1 = Session(name: "Monday", exercises: [Exercise(name: "Squat", loads: [Load(weight: 0, reps: "4-6", multiplier: 0.85, adder: 5),
                                                                                       Load(weight: 0, reps: "4-6", multiplier: 0.85, adder: 5),
                                                                                       Load(weight: 0, reps: "4-6", multiplier: 0.85, adder: 5),
                                                                                      ]),
                                                       Exercise(name: "Deadlift", loads: [Load(weight: 0, reps: "3-6", multiplier: 0.875),
                                                                                          Load(weight: 0, reps: "3-6", multiplier: 0.875),
                                                                                          Load(weight: 0, reps: "3-6", multiplier: 0.875),
                                                                                         ]),
        ])
        let w3s2 = Session(name: "Wednesday", exercises: [Exercise(name: "Bench Press", loads: [Load(weight: 0, reps: "4-6", multiplier: 0.85),
                                                                                                Load(weight: 0, reps: "4-6", multiplier: 0.85),
                                                                                                Load(weight: 0, reps: "4-6", multiplier: 0.85),
                                                                                               ]),
                                                          Exercise(name: "Horizontal Pull", loads: [Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                    Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                    Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                   ]),
                                                          Exercise(name: "Shoulder Exercise", loads: [Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                      Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                      Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                     ]),
                                                          Exercise(name: "Vertical Pull", loads: [Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                  Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                  Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                 ]),
        ])
        let w3s3 = Session(name: "Friday", exercises: [Exercise(name: "Squat", loads: [Load(weight: 0, reps: "4-6", multiplier: 0.85, adder: 10),
                                                                                      ]),
                                                       Exercise(name: "Deadlift Variation", loads: [Load(weight: 0, reps: "8", multiplier: 0),
                                                                                                   ]),
        ])
        let w3s4 = Session(name: "Saturday", exercises: [Exercise(name: "Bench Press", loads: [Load(weight: 0, reps: "4-6", multiplier: 0.85, adder:5),
                                                                                               Load(weight: 0, reps: "4-6", multiplier: 0.85, adder:5),
                                                                                               Load(weight: 0, reps: "4-6", multiplier: 0.85, adder:5),
                                                                                              ]),
                                                         Exercise(name: "Horizontal Pull", loads: [Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                   Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                   Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                  ]),
                                                         Exercise(name: "Shoulder Exercise", loads: [Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                    ]),
                                                         Exercise(name: "Vertical Pull", loads: [Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                 Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                 Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                ]),
        ])
        
        self.w3 = Week(number: 3, subtitle: "Linear Max OT Phase", sessions: [w3s1, w3s2, w3s3, w3s4])
        
        // Week 4 -------------------------------------------------------------------------------------------------
        let w4s1 = Session(name: "Monday", exercises: [Exercise(name: "Squat", loads: [Load(weight: 0, reps: "3",                                                                                multiplier: 0.9, adder: -5),
                                                                                       Load(weight: 0, reps: "3", multiplier: 0.9, adder: 0),
                                                                                       Load(weight: 0, reps: "3", multiplier: 0.9, adder: 5),
                                                                                      ]),
                                                       Exercise(name: "Deadlift Variation", loads: [Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                    Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                   ]),
                                                       Exercise(name: "Optional Exercise 1", loads: [Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                    ]),
                                                       Exercise(name: "Optional Exercise 2", loads: [Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                    ]),
        ])
        
        let w4s2 = Session(name: "Wednesday", exercises: [Exercise(name: "Bench Press", loads: [Load(weight: 0, reps: "3", multiplier: 0.875, mRoundAdder: -5.0),
                                                                                                Load(weight: 0, reps: "3", multiplier: 0.9, mRoundAdder: -5.0),
                                                                                                Load(weight: 0, reps: "3", multiplier: 0.9),
                                                                                               ]),
                                                          Exercise(name: "Horizontal Pull", loads: [Load(weight: 0, reps: "10", multiplier: 0),
                                                                                                    Load(weight: 0, reps: "10", multiplier: 0),
                                                                                                    Load(weight: 0, reps: "8", multiplier: 0),
                                                                                                    Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                   ]),
                                                          Exercise(name: "Shoulder Exercise", loads: [Load(weight: 0, reps: "12", multiplier: 0),
                                                                                                      Load(weight: 0, reps: "12", multiplier: 0),
                                                                                                      Load(weight: 0, reps: "10", multiplier: 0),
                                                                                                      Load(weight: 0, reps: "8", multiplier: 0),
                                                                                                     ]),
                                                          Exercise(name: "Vertical Pull", loads: [Load(weight: 0, reps: "12", multiplier: 0),
                                                                                                  Load(weight: 0, reps: "12", multiplier: 0),
                                                                                                  Load(weight: 0, reps: "10", multiplier: 0),
                                                                                                  Load(weight: 0, reps: "8", multiplier: 0),
                                                                                                 ]),
                                                          Exercise(name: "Optional Exercise 1", loads: [Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                        Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                        Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                       ]),
                                                          Exercise(name: "Optional Exercise 2", loads: [Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                        Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                        Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                       ]),
        ])
        
        let w4s3 = Session(name: "Friday", exercises: [Exercise(name: "Squat", loads: [Load(weight: 0, reps: "3", multiplier: 0.9, adder: 5),
                                                                                       Load(weight: 0, reps: "1-2", multiplier: 0.95, adder: 0)
                                                                                      ]),
                                                       Exercise(name: "Deadlift", loads: [Load(weight: 0, reps: "3", multiplier: 0.9, adder: 5),
                                                                                          Load(weight: 0, reps: "1-2", multiplier: 0.95)
                                                                                         ]),
                                                       Exercise(name: "Optional Exercise 1", loads: [Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                    ]),
                                                       Exercise(name: "Optional Exercise 2", loads: [Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                    ]),
        ])
        let w4s4 = Session(name: "Saturday", exercises: [Exercise(name: "Bench Press", loads: [Load(weight: 0, reps: "3", multiplier: 0.875),
                                                                                               Load(weight: 0, reps: "2-4", multiplier: 0.9),
                                                                                               Load(weight: 0, reps: "1-2", multiplier: 0.95),
                                                                                              ]),
                                                         Exercise(name: "Horizontal Pull", loads: [Load(weight: 0, reps: "10", multiplier: 0),
                                                                                                   Load(weight: 0, reps: "10", multiplier: 0),
                                                                                                   Load(weight: 0, reps: "8", multiplier: 0),
                                                                                                   Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                  ]),
                                                         Exercise(name: "Shoulder Exercise", loads: [Load(weight: 0, reps: "12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "10", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "8", multiplier: 0),
                                                                                                    ]),
                                                         Exercise(name: "Vertical Pull", loads: [Load(weight: 0, reps: "12", multiplier: 0),
                                                                                                 Load(weight: 0, reps: "12", multiplier: 0),
                                                                                                 Load(weight: 0, reps: "10", multiplier: 0),
                                                                                                 Load(weight: 0, reps: "8", multiplier: 0),
                                                                                                ]),
                                                         Exercise(name: "Optional Exercise 1", loads: [Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                       Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                       Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                      ]),
                                                         Exercise(name: "Optional Exercise 2", loads: [Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                       Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                       Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                      ]),
        ])
        
        self.w4 = Week(number: 4, subtitle: "Heavy Weight Acclimation", sessions: [w4s1, w4s2, w4s3, w4s4])
        
        // Week 5 -------------------------------------------------------------------------------------------------
        
        let w5s1 = Session(name: "Monday", exercises: [Exercise(name: "Squat", loads: [Load(weight: 0, reps: "1-4",                                                                                multiplier: 0.975),
                                                                                      ]),
                                                       Exercise(name: "Deadlift", loads: [Load(weight: 0, reps: "4", multiplier: 0.675),
                                                                                          Load(weight: 0, reps: "4", multiplier: 0.7),
                                                                                          Load(weight: 0, reps: "2", multiplier: 0.725),
                                                                                         ]),
                                                       Exercise(name: "Optional Exercise 1", loads: [Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                    ]),
                                                       Exercise(name: "Optional Exercise 2", loads: [Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                    ]),
        ])
        
        let w5s2 = Session(name: "Wednesday", exercises: [Exercise(name: "Bench Press", loads: [Load(weight: 0, reps: "1-4", multiplier: 0.975),
                                                                                               ]),
                                                          Exercise(name: "Horizontal Pull", loads: [Load(weight: 0, reps: "8", multiplier: 0),
                                                                                                    Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                    Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                   ]),
                                                          Exercise(name: "Shoulder Exercise", loads: [Load(weight: 0, reps: "8", multiplier: 0),
                                                                                                      Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                      Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                     ]),
                                                          Exercise(name: "Vertical Pull", loads: [Load(weight: 0, reps: "8", multiplier: 0),
                                                                                                  Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                  Load(weight: 0, reps: "6", multiplier: 0),
                                                                                                 ]),
                                                          Exercise(name: "Optional Exercise 1", loads: [Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                        Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                        Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                       ]),
                                                          Exercise(name: "Optional Exercise 2", loads: [Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                        Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                        Load(weight: 0, reps: "8-12", multiplier: 0),
                                                                                                       ]),
                                                          
        ])
        
        let w5s3 = Session(name: "Friday", exercises: [Exercise(name: "Deadlift", loads: [Load(weight: 0, reps: "1-4", multiplier: 0.975),
                                                                                         ]),
                                                       Exercise(name: "Optional Exercise 1", loads: [Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                    ]),
                                                       Exercise(name: "Optional Exercise 2", loads: [Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                     Load(weight: 0, reps: "4-12", multiplier: 0),
                                                                                                    ]),
        ])
        
        self.w5 = Week(number: 5, subtitle: "High Intensity Strength", sessions: [w5s1, w5s2, w5s3])
        
        // Week 6 -------------------------------------------------------------------------------------------------
        
        self.weeks = [w1, w2, w3, w4, w5]
    }
}

// w1.updateWeights(weights: [190, 225, 295])
// w2.updateWeights(weights: [190, 225, 295])
