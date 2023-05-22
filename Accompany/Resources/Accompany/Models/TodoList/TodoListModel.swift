//
//  TodoListModel.swift
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
  public var todos: [TodoModel]?
  
  // MARK: - Methods
  
  /// A method that we use to load the default data.
  /// - Returns: An array of TodoListModel objects.
  static func loadTodoListsData() -> [TodoListModel] {
    let todoStrings = Strings.Todo.Title.self
    return [TodoListModel(trimester: .firstTrimester,
                          todos: [TodoModel(title: todoStrings.FirstTrimester.geneTesting),
                                  TodoModel(title: todoStrings.FirstTrimester.d3Testing),
                                  TodoModel(title: todoStrings.FirstTrimester.askMedicalHistory),
                                  TodoModel(title: todoStrings.FirstTrimester.firstUltrasound),
                                  TodoModel(title: todoStrings.FirstTrimester.prenatalExaminationBloodTests),
                                  TodoModel(title: todoStrings.FirstTrimester.regularBloodTest),
                                  TodoModel(title: todoStrings.FirstTrimester.neisseriaGonorrhoeaeChlamydiaTrachomatisTests),
                                  TodoModel(title: todoStrings.FirstTrimester.spinalMuscularAtrophy),
                                  TodoModel(title: todoStrings.FirstTrimester.smearHumanPapillomaVirus),
                                  TodoModel(title: todoStrings.FirstTrimester.thyroidFunctionTests),
                                  TodoModel(title: todoStrings.FirstTrimester.torchScreen),
                                  TodoModel(title: todoStrings.FirstTrimester.fragileXSyndrome),
                                  TodoModel(title: todoStrings.FirstTrimester.diabetesTest),
                                  TodoModel(title: todoStrings.FirstTrimester.toxoplasmosisScreening),
                                  TodoModel(title: todoStrings.FirstTrimester.nonInvasivePrenatalTest),
                                  TodoModel(title: todoStrings.FirstTrimester.maternalBloodDownsSyndromeScreening),
                                  TodoModel(title: todoStrings.FirstTrimester.preeclampsiaRiskAssessment),
                                  TodoModel(title: todoStrings.FirstTrimester.pregnantWomanPhysicalFitness)
                                 ]),
            TodoListModel(trimester: .secondTrimester,
                          todos: [TodoModel(title: todoStrings.SecondTrimester.amniocentesis),
                                  TodoModel(title: todoStrings.SecondTrimester.maternalBloodScreening),
                                  TodoModel(title: todoStrings.SecondTrimester.pretermBirthRiskAssessment),
                                  TodoModel(title: todoStrings.SecondTrimester.healthEducationConsultation),
                                  TodoModel(title: todoStrings.SecondTrimester.seasonalInfluenzaVaccination),
                                  TodoModel(title: todoStrings.SecondTrimester.ultrasoundLevelII),
                                  TodoModel(title: todoStrings.SecondTrimester.gestationalDiabetesMellitus),
                                  TodoModel(title: todoStrings.SecondTrimester.syphilisTest)
                                 ]),
            TodoListModel(trimester: .thirdTrimester,
                          todos: [TodoModel(title:todoStrings.ThirdTrimester.gestationalDiabetesMellitusReexamination),
                                  TodoModel(title: todoStrings.ThirdTrimester.pertussisVaccination),
                                  TodoModel(title: todoStrings.ThirdTrimester.fetalGrowthAssessment),
                                  TodoModel(title: todoStrings.ThirdTrimester.pregnantWomanPhysicalFitness),
                                  TodoModel(title: todoStrings.ThirdTrimester.fetalUltrasoundTest),
                                  TodoModel(title: todoStrings.ThirdTrimester.nutritionConsultation),
                                  TodoModel(title: todoStrings.ThirdTrimester.fetalMovementRecord),
                                  TodoModel(title: todoStrings.ThirdTrimester.prenatalBloodAndUrineExamination),
                                  TodoModel(title: todoStrings.ThirdTrimester.fetalHealthMonitoring),
                                  TodoModel(title: todoStrings.ThirdTrimester.fetalGrowthAssessment),
                                  TodoModel(title: todoStrings.ThirdTrimester.fetalMonitor)
                                 ]),
            TodoListModel(trimester: .after,
                          todos: [TodoModel(title: todoStrings.after.hpvVaccination),
                                  TodoModel(title: todoStrings.after.hpvScreening),
                                  TodoModel(title: todoStrings.after.pertussisVaccination),
                                  TodoModel(title: todoStrings.after.papSmear)
                                 ]),
    ]
  }
  
  /// A method that displays to-do items on lists based on the trimester in which the user is currently enrolled
  /// - Parameters:
  ///   - trimester: Which trimester the user is currently enrolled in.
  ///   - todoLists: An array of TodoListModel displayed on the view.
  ///   - status: A status of  todo item.
  /// - Returns: An array of todo object.
  static func getTodos(of trimester: Trimester,
                       from todoLists: [TodoListModel],
                       status: ToDoStatus) -> [TodoModel]? {
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
