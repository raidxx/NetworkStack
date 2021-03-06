//
// Copyright 2017 niji
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Foundation
import SwiftyJSON

extension User: Swifty {
  init(json: JSON) {
    self.identifier = json[JSONKeys.identifier].intValue
    self.firstName = json[JSONKeys.firstName].stringValue
    self.lastName = json[JSONKeys.lastName].stringValue
    self.age = json[JSONKeys.age].intValue
  }
  
  func toJSON() -> JSON {
    var json: JSON = JSON(dictionaryLiteral: [])
    json[JSONKeys.firstName].string = self.firstName
    json[JSONKeys.lastName].string = self.lastName
    json[JSONKeys.age].int = self.age
    return json
  }
}
