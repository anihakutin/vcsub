// Import and register all your controllers from the importmap under controllers/*

import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "@hotwired/stimulus-webpack-helpers"

// Start application
const application = Application.start()

// Register controllers manually
import ClipboardController from "./clipboard_controller"
import SliderController from "./slider_controller"

application.register("clipboard", ClipboardController)
application.register("slider", SliderController)
