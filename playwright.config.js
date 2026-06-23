// Playwright Configuration for UI Testing
const { defineConfig, devices } = require('@playwright/test');

module.exports = defineConfig({
  // Test directory and files to run
  testDir: './public/tests',
  
  // Files to match
  testMatch: '**/*.spec.js',
  
  // Run tests in parallel (set to 1 for debugging)
  fullyParallel: true,
  
  // Fail the build on CI if there are test failures
  forbidOnly: !!process.env.CI,
  
  // Retry failed tests on CI
  retries: process.env.CI ? 2 : 0,
  
  // Workers to run tests (set to 1 for debugging)
  workers: process.env.CI ? 1 : undefined,
  
  // Reporter configuration
  reporter: [
    ['html', { outputFolder: 'test-results/html-report' }],
    ['json', { outputFile: 'test-results/test-results.json' }],
    ['list']
  ],
  
  // Shared settings for all projects
  use: {
    // Base URL for tests
    baseURL: process.env.BASE_URL || 'http://localhost:3000',
    
    // Collect traces for failed tests
    trace: 'on-first-retry',
    
    // Collect screenshots on failure
    screenshot: 'only-on-failure',
    
    // Video recording on failure
    video: 'retain-on-failure',
    
    // Ignore HTTPS errors in local development
    ignoreHTTPSErrors: true,
    
    // Timeouts
    actionTimeout: 10000,
    navigationTimeout: 30000,
  },

  // Configure projects for different browsers
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
    {
      name: 'firefox',
      use: { ...devices['Desktop Firefox'] },
    },
    {
      name: 'webkit',
      use: { ...devices['Desktop Safari'] },
    },
    // Mobile projects
    {
      name: 'Mobile Chrome',
      use: { ...devices['Pixel 5'] },
    },
    {
      name: 'Mobile Safari',
      use: { ...devices['iPhone 12'] },
    },
  ],

  // Web server configuration for local testing
  webServer: {
    command: 'npm start',
    url: 'http://localhost:3000',
    reuseExistingServer: !process.env.CI,
    timeout: 120000,
  },
  
  // Output directory for test artifacts
  outputDir: 'test-results',
});
