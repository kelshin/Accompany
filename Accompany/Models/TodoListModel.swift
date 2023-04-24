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
                          todos: [Todo(title: "Maternal blood Down’s syndrome screening"),
                                  Todo(title: "Health education consultation for prenatal check-up"),
                                  Todo(title: "Amniocentesis, Amniotic fluid"),
                                  Todo(title: "Premature birth risk assessment"),
                                  Todo(title: "Anomaly Scan"),
                                  Todo(title: "Seasonal influenza vaccination"),
                                  Todo(title: "Syphilis"),
                                  Todo(title: "Gestational diabetes screening")
                                 ]),
            TodoListModel(trimester: .thirdTrimester,
                          todos: [Todo(title: "Gestational diabetes reexamination"),
                                  Todo(title: "Pregnant woman physical fitness"),
                                  Todo(title: "Nutrition consultation"),
                                  Todo(title: "Diphtheria and tetanus toxoid with acellular pertussis vaccination"),
                                  Todo(title: "Fetal growth assessment"),
                                  Todo(title: "Fetal ultrasound test"),
                                  Todo(title: "Fetal movement record"),
                                  Todo(title: "Fetal  health monitoring"),
                                  Todo(title: "Fetal monitor"),
                                  Todo(title: "Prenatal blood and urine examination"),
                                  Todo(title: "GBS(Group B Streptococcus test)")
                                 ]),
            TodoListModel(trimester: .after,
                          todos: [Todo(title: "Pertussis vaccination"),
                                  Todo(title: "Pap smear"),
                                  Todo(title: "HPV vaccination"),
                                  Todo(title: "HPV screening"),
                                  Todo(title: "Family planning"),
                                 ]),
    ]
  }
  
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
