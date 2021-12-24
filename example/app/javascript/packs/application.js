// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import { Application } from "@hotwired/stimulus";
import { definitionsFromContext } from "@hotwired/stimulus-webpack-helpers";

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// Install @hotwired/stimulus and run
// https://stimulus.hotwired.dev/handbook/installing
window.Stimulus = Application.start();
const context = require.context("../controllers", true, /\.js$/);
Stimulus.load(definitionsFromContext(context));
