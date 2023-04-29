import Foundation
import XcodeProj
import PathKit

guard CommandLine.arguments.count == 2 else {
    let arg0 = Path(CommandLine.arguments[0]).lastComponent
    fputs("usage: \(arg0) <project>\n", stderr)
    exit(1)
}

let projectPath = Path(CommandLine.arguments[1])
let xcodeproj = try XcodeProj(path: projectPath)
xcodeproj.pbxproj.invalidateUUIDs()
xcodeproj.pbxproj.rootObject = xcodeproj.pbxproj.rootObject // https://github.com/tuist/XcodeProj/issues/528
try xcodeproj.write(path: projectPath, override: true, outputSettings: PBXOutputSettings(projFileListOrder: .byUUID, projNavigatorFileOrder: .unsorted, projBuildPhaseFileOrder: .byFilename, projReferenceFormat: .xcode))
