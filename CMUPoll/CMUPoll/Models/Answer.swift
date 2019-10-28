//
//  Answer.swift
//  CMUPoll
//
//  Created by Aiden Lee on 10/28/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import Foundation
import SwiftUI

struct Answer: Identifiable {
  var id = UUID()
  var user_id : UUID
  var question_id: UUID
  var option_id: UUID  
}


