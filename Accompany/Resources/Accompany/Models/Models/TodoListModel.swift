//
//  TodoList.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-16.
//

import Foundation

// MARK: - Enums

/// An enum that indicates the descriptions based on different trimesters
enum Trimester: String, CaseIterable, Codable {
  
  /// The first trimester.
  case firstTrimester = "1st Trimester"
  
  /// The second trimester.
  case secondTrimester = "2nd Trimester"
  
  /// The third trimester.
  case thirdTrimester = "3rd Trimester"
  
  /// After trimesters.
  case after = "After"
}

/// An enum used to distinguish the status of a to-do item.
enum ToDoStatus: String, CaseIterable, Codable {
  
  /// Shows all to do items.
  case all = "All"
  
  /// Shows the items marked as done.
  case done = "Done"
  
  /// Shows the items marked as not done.
  case notDone = "Not Done"
}

// MARK: - Model

/// A model that we use to create a todolist.
struct TodoListModel: Codable {
 
  // MARK: - Properties
  
  /// An ID used to generate unique IDs for each to-do item.
  public var id = UUID()
  
  /// The trimester that the user is in.
  public let trimester: Trimester
  
  /// An array that holds Todo items within a todo list.
  public var todos: [Todo]?
  
  // MARK: - Methods
  
  /// A method that we use to load the default data.
  /// - Returns: An array of TodoListModel objects.
  static func loadTodoListsData() -> [TodoListModel] {
    let todoStrings = Strings.Todo.Title.self
    return [TodoListModel(trimester: .firstTrimester,
                          todos: [Todo(title: todoStrings.FirstTrimester.geneTesting),
                                  Todo(title: todoStrings.FirstTrimester.d3Testing),
                                  Todo(title: todoStrings.FirstTrimester.askMedicalHistory),
                                  Todo(title: todoStrings.FirstTrimester.firstUltrasound),
                                  Todo(title: todoStrings.FirstTrimester.prenatalExaminationBloodTests),
                                  Todo(title: todoStrings.FirstTrimester.regularBloodTest),
                                  Todo(title: todoStrings.FirstTrimester.neisseriaGonorrhoeaeChlamydiaTrachomatisTests),
                                  Todo(title: todoStrings.FirstTrimester.spinalMuscularAtrophy),
                                  Todo(title: todoStrings.FirstTrimester.smearHumanPapillomaVirus),
                                  Todo(title: todoStrings.FirstTrimester.thyroidFunctionTests),
                                  Todo(title: todoStrings.FirstTrimester.torchScreen),
                                  Todo(title: todoStrings.FirstTrimester.fragileXSyndrome),
                                  Todo(title: todoStrings.FirstTrimester.diabetesTest),
                                  Todo(title: todoStrings.FirstTrimester.toxoplasmosisScreening),
                                  Todo(title: todoStrings.FirstTrimester.nonInvasivePrenatalTest),
                                  Todo(title: todoStrings.FirstTrimester.maternalBloodDownsSyndromeScreening),
                                  Todo(title: todoStrings.FirstTrimester.preeclampsiaRiskAssessment),
                                  Todo(title: todoStrings.FirstTrimester.pregnantWomanPhysicalFitness)
                                 ]),
            TodoListModel(trimester: .secondTrimester,
                          todos: [Todo(title: todoStrings.SecondTrimester.amniocentesis),
                                  Todo(title: todoStrings.SecondTrimester.maternalBloodScreening),
                                  Todo(title: todoStrings.SecondTrimester.pretermBirthRiskAssessment),
                                  Todo(title: todoStrings.SecondTrimester.healthEducationConsultation),
                                  Todo(title: todoStrings.SecondTrimester.seasonalInfluenzaVaccination),
                                  Todo(title: todoStrings.SecondTrimester.ultrasoundLevelII),
                                  Todo(title: todoStrings.SecondTrimester.gestationalDiabetesMellitus),
                                  Todo(title: todoStrings.SecondTrimester.syphilisTest)
                                 ]),
            TodoListModel(trimester: .thirdTrimester,
                          todos: [Todo(title:todoStrings.ThirdTrimester.gestationalDiabetesMellitusReexamination),
                                  Todo(title: todoStrings.ThirdTrimester.pertussisVaccination),
                                  Todo(title: todoStrings.ThirdTrimester.fetalGrowthAssessment),
                                  Todo(title: todoStrings.ThirdTrimester.pregnantWomanPhysicalFitness),
                                  Todo(title: todoStrings.ThirdTrimester.fetalUltrasoundTest),
                                  Todo(title: todoStrings.ThirdTrimester.nutritionConsultation),
                                  Todo(title: todoStrings.ThirdTrimester.fetalMovementRecord),
                                  Todo(title: todoStrings.ThirdTrimester.prenatalBloodAndUrineExamination),
                                  Todo(title: todoStrings.ThirdTrimester.fetalHealthMonitoring),
                                  Todo(title: todoStrings.ThirdTrimester.fetalGrowthAssessment),
                                  Todo(title: todoStrings.ThirdTrimester.fetalMonitor)
                                 ]),
            TodoListModel(trimester: .after,
                          todos: [Todo(title: todoStrings.after.hpvVaccination),
                                  Todo(title: todoStrings.after.hpvScreening),
                                  Todo(title: todoStrings.after.pertussisVaccination),
                                  Todo(title: todoStrings.after.papSmear)
                                 ]),
    ]
  }
  
  /// A method that displays to-do items on lists based on the trimester in which the user is currently enrolled
  /// - Parameters:
  ///   - trimester: Which trimester the user is currently enrolled in.
  ///   - todoLists: An array of TodoListModel displayed on the view.
  ///   - status: A status of  todo item.
  /// - Returns: An array of todo object.
  static func getTodos(of trimester: Trimester, from todoLists: [TodoListModel], status: ToDoStatus) -> [Todo]? {
    switch status {
    case .all:
      return todoLists.filter { $0.trimester == trimester }.first?.todos
    case .done:
      return todoLists.filter { $0.trimester == trimester }.first?.todos?.filter{ $0.isCompleted == true }
    case .notDone:
      return todoLists.filter { $0.trimester == trimester }.first?.todos?.filter{ $0.isCompleted == false }
    }
  }
}
