@testable import TMDbCore

import RxSwift
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let assembly = CoreAssembly()
let resultsViewController = assembly.searchAssembly.viewController()

resultsViewController.view.frame = CGRect(x: 0, y: 0, width: 375, height: 667)

PlaygroundPage.current.liveView = resultsViewController
