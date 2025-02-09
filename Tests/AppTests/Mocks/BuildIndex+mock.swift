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

@testable import App
import Foundation


extension BuildIndex.Model {

    static let id: App.Build.Id = UUID(uuidString: "2f16f873-1ebf-4987-b4ce-a9f22269d13a")!

    static var mock: Self {
        .init(
            owner: "foo",
            ownerName: "Foo",
            repositoryName: "foobar",
            packageName: "foobar",
            //            stable: .init(name: "1.2.3", builds: []),
            //            latest: .init(name: "main", builds: []),
            //            beta: .init(name: "2.0.0b1", builds: [])
            //            ,
            buildGroups: [
                .init(
                    name: "1.2.3",
                    kind: .release,
                    builds: [
                        .init(id: Self.id, swiftVersion: .v5_5, platform: .ios,                status: .ok),
                        .init(id: Self.id, swiftVersion: .v5_5, platform: .macosSpm,           status: .failed),
                        .init(id: Self.id, swiftVersion: .v5_5, platform: .macosXcodebuild,    status: .triggered),
                        // The Linux build for v5.5 is intentionally missing to test the representation of a pending build
                        // .init(id: Self.id, swiftVersion: .v5_5, platform: .linux,              status: .ok),
                        .init(id: Self.id, swiftVersion: .v5_5, platform: .tvos,               status: .timeout),
                        .init(id: Self.id, swiftVersion: .v5_5, platform: .watchos,            status: .infrastructureError),
                        //
                        .init(id: Self.id, swiftVersion: .v5_4, platform: .ios,                status: .ok),
                        .init(id: Self.id, swiftVersion: .v5_4, platform: .macosSpm,           status: .failed),
                        .init(id: Self.id, swiftVersion: .v5_4, platform: .macosXcodebuild,    status: .triggered),
                        .init(id: Self.id, swiftVersion: .v5_4, platform: .linux,              status: .ok),
                        .init(id: Self.id, swiftVersion: .v5_4, platform: .tvos,               status: .ok),
                        .init(id: Self.id, swiftVersion: .v5_4, platform: .watchos,            status: .ok),
                        //
                        .init(id: Self.id, swiftVersion: .v5_3, platform: .ios,                status: .ok),
                        .init(id: Self.id, swiftVersion: .v5_3, platform: .macosSpm,           status: .failed),
                        .init(id: Self.id, swiftVersion: .v5_3, platform: .macosXcodebuild,    status: .triggered),
                        .init(id: Self.id, swiftVersion: .v5_3, platform: .linux,              status: .ok),
                        .init(id: Self.id, swiftVersion: .v5_3, platform: .tvos,               status: .ok),
                        .init(id: Self.id, swiftVersion: .v5_3, platform: .watchos,            status: .ok),
                    ]
                ),
                .init(
                    name: "main",
                    kind: .defaultBranch,
                    builds: [
                        .init(id: Self.id, swiftVersion: .v5_5, platform: .ios,                status: .ok),
                        .init(id: Self.id, swiftVersion: .v5_5, platform: .macosSpm,           status: .failed),
                        .init(id: Self.id, swiftVersion: .v5_5, platform: .macosXcodebuild,    status: .triggered),
                        .init(id: Self.id, swiftVersion: .v5_5, platform: .linux,              status: .ok),
                        .init(id: Self.id, swiftVersion: .v5_5, platform: .tvos,               status: .ok),
                        .init(id: Self.id, swiftVersion: .v5_5, platform: .watchos,            status: .ok),
                        //
                        .init(id: Self.id, swiftVersion: .v5_4, platform: .ios,                status: .ok),
                        .init(id: Self.id, swiftVersion: .v5_4, platform: .macosSpm,           status: .failed),
                        .init(id: Self.id, swiftVersion: .v5_4, platform: .macosXcodebuild,    status: .triggered),
                        .init(id: Self.id, swiftVersion: .v5_4, platform: .linux,              status: .ok),
                        .init(id: Self.id, swiftVersion: .v5_4, platform: .tvos,               status: .ok),
                        .init(id: Self.id, swiftVersion: .v5_4, platform: .watchos,            status: .ok),
                        //
                        .init(id: Self.id, swiftVersion: .v5_3, platform: .ios,                status: .ok),
                        .init(id: Self.id, swiftVersion: .v5_3, platform: .macosSpm,           status: .failed),
                        .init(id: Self.id, swiftVersion: .v5_3, platform: .macosXcodebuild,    status: .triggered),
                        .init(id: Self.id, swiftVersion: .v5_3, platform: .linux,              status: .ok),
                        .init(id: Self.id, swiftVersion: .v5_3, platform: .tvos,               status: .ok),
                        .init(id: Self.id, swiftVersion: .v5_3, platform: .watchos,            status: .ok),
                    ]
                ),
                .init(
                    name: "2.0.0-b1",
                    kind: .preRelease,
                    builds: [
                        .init(id: Self.id, swiftVersion: .v5_5, platform: .ios,                status: .ok),
                        .init(id: Self.id, swiftVersion: .v5_5, platform: .macosSpm,           status: .failed),
                        .init(id: Self.id, swiftVersion: .v5_5, platform: .macosXcodebuild,    status: .triggered),
                        .init(id: Self.id, swiftVersion: .v5_5, platform: .linux,              status: .ok),
                        .init(id: Self.id, swiftVersion: .v5_5, platform: .tvos,               status: .ok),
                        .init(id: Self.id, swiftVersion: .v5_5, platform: .watchos,            status: .ok),
                        //
                        .init(id: Self.id, swiftVersion: .v5_4, platform: .ios,                status: .ok),
                        .init(id: Self.id, swiftVersion: .v5_4, platform: .macosSpm,           status: .failed),
                        .init(id: Self.id, swiftVersion: .v5_4, platform: .macosXcodebuild,    status: .triggered),
                        .init(id: Self.id, swiftVersion: .v5_4, platform: .linux,              status: .ok),
                        .init(id: Self.id, swiftVersion: .v5_4, platform: .tvos,               status: .ok),
                        .init(id: Self.id, swiftVersion: .v5_4, platform: .watchos,            status: .ok),
                        //
                        .init(id: Self.id, swiftVersion: .v5_3, platform: .ios,                status: .ok),
                        .init(id: Self.id, swiftVersion: .v5_3, platform: .macosSpm,           status: .failed),
                        .init(id: Self.id, swiftVersion: .v5_3, platform: .macosXcodebuild,    status: .triggered),
                        .init(id: Self.id, swiftVersion: .v5_3, platform: .linux,              status: .ok),
                        .init(id: Self.id, swiftVersion: .v5_3, platform: .tvos,               status: .ok),
                        .init(id: Self.id, swiftVersion: .v5_3, platform: .watchos,            status: .ok),
                    ]
                )
            ]
        )
    }
}
