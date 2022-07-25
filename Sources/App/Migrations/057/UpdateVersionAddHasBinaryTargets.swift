// Copyright 2020-2021 Dave Verwer, Sven A. Schmidt, and other contributors.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Fluent

struct UpdateVersionAddHasBinaryTargets: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("versions")
            .field("has_binary_targets", .bool, .sql(.default(false)), .required)
            .update()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("versions")
            .deleteField("has_binary_targets")
            .update()
    }
}
