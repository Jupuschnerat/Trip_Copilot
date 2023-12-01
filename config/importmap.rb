# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true
pin "flatpickr", to: "https://ga.jspm.io/npm:flatpickr@4.6.13/dist/esm/index.js"
pin "stimulus-flatpickr", to: "https://ga.jspm.io/npm:stimulus-flatpickr@3.0.0-0/dist/index.m.js"
pin "amadeus", to: "https://ga.jspm.io/npm:amadeus@9.0.0/lib/amadeus.js"
pin "#util.inspect.js", to: "https://ga.jspm.io/npm:@jspm/core@2.0.1/nodelibs/@empty.js"
pin "bluebird", to: "https://ga.jspm.io/npm:bluebird@3.7.2/js/browser/bluebird.js"
pin "buffer", to: "https://ga.jspm.io/npm:@jspm/core@2.0.1/nodelibs/browser/buffer.js"
pin "call-bind/callBound", to: "https://ga.jspm.io/npm:call-bind@1.0.5/callBound.js"
pin "define-data-property", to: "https://ga.jspm.io/npm:define-data-property@1.1.1/index.js"
pin "events", to: "https://ga.jspm.io/npm:@jspm/core@2.0.1/nodelibs/browser/events.js"
pin "function-bind", to: "https://ga.jspm.io/npm:function-bind@1.1.2/index.js"
pin "get-intrinsic", to: "https://ga.jspm.io/npm:get-intrinsic@1.2.2/index.js"
pin "gopd", to: "https://ga.jspm.io/npm:gopd@1.0.1/index.js"
pin "has-property-descriptors", to: "https://ga.jspm.io/npm:has-property-descriptors@1.0.1/index.js"
pin "has-proto", to: "https://ga.jspm.io/npm:has-proto@1.0.1/index.js"
pin "has-symbols", to: "https://ga.jspm.io/npm:has-symbols@1.0.3/index.js"
pin "hasown", to: "https://ga.jspm.io/npm:hasown@2.0.0/index.js"
pin "http", to: "https://ga.jspm.io/npm:@jspm/core@2.0.1/nodelibs/browser/http.js"
pin "https", to: "https://ga.jspm.io/npm:@jspm/core@2.0.1/nodelibs/browser/https.js"
pin "object-inspect", to: "https://ga.jspm.io/npm:object-inspect@1.13.1/index.js"
pin "process", to: "https://ga.jspm.io/npm:@jspm/core@2.0.1/nodelibs/browser/process-production.js"
pin "qs", to: "https://ga.jspm.io/npm:qs@6.11.2/lib/index.js"
pin "set-function-length", to: "https://ga.jspm.io/npm:set-function-length@1.1.1/index.js"
pin "side-channel", to: "https://ga.jspm.io/npm:side-channel@1.0.4/index.js"
pin "util", to: "https://ga.jspm.io/npm:@jspm/core@2.0.1/nodelibs/browser/util.js"
