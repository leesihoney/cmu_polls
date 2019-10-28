//
//  Option.swift
//  CMUPoll
//
//  Created by Aiden Lee on 10/28/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import Foundation
import SwiftUI

struct Option: Identifiable {
  var id = UUID()
  var text: String
  var question_id: UUID
}


