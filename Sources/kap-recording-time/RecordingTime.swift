import Cocoa

final class AppDelegate: NSObject, NSApplicationDelegate {
  private var statusItem: NSStatusItem?
  private var startTime: Date = Date()

  private var startImmediately: Bool
  private var hideHours: Bool
  private var timer: Timer?

  init(
    startImmediately: Bool,
    hideHours: Bool
  ) {
    self.startImmediately = startImmediately
    self.hideHours = hideHours
  }


  func applicationDidFinishLaunching(_ notification: Notification) {
    statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    statusItem?.button?.font = NSFont.monospacedDigitSystemFont(ofSize: NSFont.systemFontSize, weight: .regular)
    statusItem?.highlightMode = false

    if let button = statusItem?.button {
      // Center the text vertically
      button.frame = CGRect(x: 0.0, y: -2, width: button.frame.width, height: button.frame.height)
    }

    if startImmediately {
      startTimer()
    } else {
      waitForInput()
    }
  }

  private func waitForInput() {
    print("Waiting for any input to start the timer")
    _ = readLine()
    startTimer()
  }

  private func startTimer() {
    timer?.invalidate()
    startTime = Date()

    timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
      let interval = Date() - self.startTime
      self.statusItem?.button?.title = self.getString(time: Int(interval))
    }
  }

  private func getString(time: Int) -> String {
    let hours = Int(time) / 3600
    let minutes = Int(time) / 60 % 60
    let seconds = Int(time) % 60

    if hideHours && hours == 0 {
      return String(format: "%02i:%02i", minutes, seconds)
    } else {
      return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
  }
}
