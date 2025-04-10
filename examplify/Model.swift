//
//  Model.swift
//  examplify
//
//  Created by Manthan Vanani on 05/03/25.
//

import UIKit

struct QuestionModel {
    var uuid : String = UUID().uuidString
    var question: String?
    var description : String?
    var options: [OptionModel]
    var selection: Int = 0
    var isflag : Bool = false
    var outline : FillOption = .outline
    var option : CellOption = .none
    var selectedOption : OptionModel? = nil
}

struct OptionModel {
    var uuid : String = UUID().uuidString
    var key: String
    var value: String
    var isAnswer: Bool
}

enum CellOption : Int{
    case none = 0
    case isDone = 1
}

enum FillOption : Int{
    case outline = 0
    case filled = 1
    case visible = 2
}
