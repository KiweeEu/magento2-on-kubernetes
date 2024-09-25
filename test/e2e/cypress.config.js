const { defineConfig } = require('cypress')

module.exports = defineConfig({
  defaultCommandTimeout: 30000,
  requestTimeout: 30000,
  pageLoadTimeout: 30000,
  video: false,
  viewportWidth: 1280,
  viewportHeight: 800,
  retries: {
    runMode: 0,
    openMode: 0,
  },
  e2e: {
    // We've imported your old cypress plugins here.
    // You may want to clean this up later by importing these.
    setupNodeEvents(on, config) {
      return require('./cypress/plugins/index.js')(on, config)
    },
    baseUrl:
      'https://ingress-nginx-nginx-ingress-controller.default.svc.cluster.local/',
    specPattern: 'cypress/e2e/**/*.{spec.js,feature}',
  },
})
