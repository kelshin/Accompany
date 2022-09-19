//
//  TodoList.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-16.
//

import Foundation

enum Trimester: String, CaseIterable, Codable {
  
  case firstTrimester = "1st Trimester"
  case secondTrimester = "2nd Trimester"
  case thirdTrimester = "3rd Trimester"
  case after = "After"
  
}

enum ToDoStatus: String, CaseIterable, Codable {
  
  case all = "All"
  case done = "Done"
  case notDone = "Not Done"
  
}

struct TodoList: Codable {
  
  var id = UUID()
  var trimester: Trimester
  public var todos: [Todo]?
  
  static func loadSampleTodoLists() -> [TodoList] {
    return [
      TodoList(trimester: .firstTrimester, todos: [
        Todo(title: "Ask Medical History", isCompleted: false, note: "Type notes"),
        Todo(title: "MTHFR Gene Testing", isCompleted: false, note: "Type notes"),
        Todo(title: "Nutrition Counseling & Patient Instructions (D3 Testing)", isCompleted: false, note: "Type notes"),
        Todo(title: "First Ultrasound", isCompleted: false, note: "Type notes"),
        Todo(title: "Prenatal examination and  Blood tests", isCompleted: false, note: "Type notes"),
        Todo(title: "Neisseria gonorrhoeae test & Chlamydia trachomatis test", isCompleted: false, note: "Type notes"),
        Todo(title: "Pap smear, Human papilloma virus", isCompleted: false, note: "Type notes"),
        Todo(title: "Cytomegalovirus screening", isCompleted: false, note: "Type notes"),
        Todo(title: "Diabetes test", isCompleted: false, note: "Type notes"),
        Todo(title: "NHI Regular blood screening for the first trimester", isCompleted: false, note: "Type notes"),
        Todo(title: "Spinal muscular atrophy", isCompleted: false, note: "Type notes"),
        Todo(title: "Thyroid function tests", isCompleted: false, note: "Type notes"),
        Todo(title: "Fragile X syndrome", isCompleted: false, note: "Type notes") ,
        Todo(title: "Toxoplasmosis screening", isCompleted: false, note: "Type notes"),
        Todo(title: "pregnant woman physical fitnessd", isCompleted: false, note: "Type notes"),
        Todo(title: "Non-invasive Prenatal test", isCompleted: false, note: "Type notes"),
        Todo(title: "Maternal blood Down’s syndrome screening for the first trimester", isCompleted: false, note: "Type notes"),
        Todo(title: "Preeclampsia risk assessment", isCompleted: false, note: "Type notes")
      ]),
      TodoList(trimester: .secondTrimester, todos: [
        Todo(title: "Maternal blood Down’s syndrome screening", isCompleted: false, note: "Type notes"),
        Todo(title: "Health education consultation for prenatal check-up  ", isCompleted: false, note: "Type notes"),
        Todo(title: "Amniocentesis, Amniotic fluid", isCompleted: false, note: "Type notes"),
        Todo(title: "Premature birth risk assessment", isCompleted: false, note: "Type notes"),
        Todo(title: "Anomaly Scan", isCompleted: false, note: "Type notes"),
        Todo(title: "Seasonal influenza vaccination ", isCompleted: false, note: "Type notes"),
        Todo(title: "Syphilis", isCompleted: false, note: "Type notes"),
        Todo(title: "Gestational diabetes screening", isCompleted: false, note: "Type notes")
      ]),
      TodoList(trimester: .thirdTrimester, todos: [
        Todo(title: "Gestational diabetes reexamination", isCompleted: false, note: "Type notes"),
        Todo(title: "Pregnant woman physical fitness", isCompleted: false, note: "Type notes"),
        Todo(title: "Nutrition consultation", isCompleted: false, note: "Type notes"),
        Todo(title: "Diphtheria and tetanus toxoid with acellular pertussis vaccination", isCompleted: false, note: "Type notes"),
        Todo(title: "Fetal growth assessment", isCompleted: false, note: "Type notes"),
        Todo(title: "Fetal ultrasound test", isCompleted: false, note: "Type notes"),
        Todo(title: "Fetal movement record", isCompleted: false, note: "Type notes"),
        Todo(title: "Fetal  health monitoring", isCompleted: false, note: "Type notes"),
        Todo(title: "Fetal monitor", isCompleted: false, note: "Type notes"),
        Todo(title: "Prenatal blood and urine examination  ", isCompleted: false, note: "Type notes"),
        Todo(title: "GBS (Group B Streptococcus test)", isCompleted: false, note: "Type notes")
      ]),
      TodoList(trimester: .after, todos: [
        Todo(title: "Pertussis vaccination", isCompleted: false, note: "Type notes"),
        Todo(title: "Pap smear", isCompleted: false, note: "Type notes"),
        Todo(title: "HPV vaccination ", isCompleted: false, note: "Type notes"),
        Todo(title: "HPV screening", isCompleted: false, note: "Type notes"),
        Todo(title: "Family planning", isCompleted: false, note: "Type notes"),
      ]),
    ]
  }
  
  static func getTodos(of trimester: Trimester, from todoLists: [TodoList], status: ToDoStatus) -> [Todo]? {
    switch status {
    case .all:
      return todoLists.filter { $0.trimester == trimester }.first?.todos
    case .done:
      return todoLists.filter { $0.trimester == trimester }.first?.todos?.filter{ $0.isCompleted == true }
    case .notDone:
      return todoLists.filter { $0.trimester == trimester }.first?.todos?.filter{ $0.isCompleted == false }
    }
//    return todoLists.filter { $0.trimester == trimester }.first?.todos
  }
}
