import Cocoa
import ArgumentParser

struct RecordingTime: ParsableCommand {
  @Flag(help: "Hide the hours unless needed.")
  var hideHours: Bool

  @Flag(name: .shortAndLong, help: "Start the timer immediately.")
  var startImmediately: Bool

  mutating func run() throws {
    let app = NSApplication.shared
    let delegate = AppDelegate(
      startImmediately: startImmediately,
      hideHours: hideHours
    )
    app.delegate = delegate
    app.run()
  }
}

RecordingTime.main()