# UI Testing Documentation

This document describes the UI testing setup for the Dashboard public website using Playwright.

## Overview

The UI tests are located in `public/tests/ui-tests.spec.js` and cover:

- Homepage rendering and navigation
- Page navigation (all 7 routes)
- Mobile responsive behavior
- Tab functionality
- Footer and component rendering
- Console error detection

## Test Coverage

### Current Tests (20 total)

1. **Homepage loads with correct title** - Verifies page title contains "Cloud.io"
2. **Navigation menu has all expected links** - Checks all 7 nav links exist
3. **Mobile navigation toggle works** - Tests mobile menu open/close
4. **Homepage renders hero section** - Verifies hero content loads
5. **Navigate to Virtual Machines page** - Tests routing to VM page
6. **Navigate to Containers page** - Tests routing to Containers page
7. **Navigate to Bare Metal page** - Tests routing to Bare Metal page
8. **Navigate to Confidential Compute page** - Tests routing to Conf. Compute page
9. **Navigate to Clusters page** - Tests routing to Clusters page
10. **Navigate to Pricing page** - Tests routing to Pricing page
11. **Tab switching works on Containers page** - Tests tab functionality
12. **Navbar has scroll effect on scroll** - Tests scroll effects
13. **Footer renders correctly** - Verifies footer exists
14. **Homepage has feature cards** - Checks feature cards render
15. **Pricing page shows pricing cards** - Verifies pricing cards exist
16. **Console button exists in navigation** - Checks console button
17. **No critical console errors on homepage** - Error detection
18. **Navbar adapts to different viewport sizes** - Responsive testing
19. **Page sections have fade-in animation** - Animation testing
20. **External console link is correct** - Link verification

## Prerequisites

### Install Node.js

Ensure you have Node.js 18+ installed:

```bash
node --version
```

### Install Playwright and Dependencies

```bash
# Install Playwright and browser binaries
npm run test:install

# Or manually:
npx playwright install --with-deps
```

## Running Tests

### Basic Commands

```bash
# Run all tests (default headed mode)
npm test

# Run tests with visible browser
npm run test:headed

# Run tests in debug mode
npm run test:debug

# Run tests in UI mode
npm run test:ui
```

### Browser-Specific Tests

```bash
# Run only Chromium tests
npm run test:chromium

# Run only Firefox tests
npm run test:firefox

# Run only Webkit tests
npm run test:webkit

# Run only mobile tests
npm run test:mobile
```

### CI/Production Testing

```bash
# Run tests for CI (with reporters)
npm run test:ci

# Run all tests with list reporter
npm run test:all
```

### Generate Reports

```bash
# Generate and show HTML report
npm run test:report
```

## Test Configuration

The tests are configured in `playwright.config.js`:

| Setting | Value | Description |
| --------- | ----- | ------------ |
| testDir | ./public/tests | Test file location |
| baseURL | <http://localhost:3000> | Target application URL |
| retries | 2 (CI) / 0 (local) | Failed test retries |
| workers | auto | Parallel test workers |
| reporter | html, json, list | Report formats |

### Environment Variables

```bash
# Override base URL
export BASE_URL=http://localhost:8080
npm test

# Or inline:
BASE_URL=http://localhost:8080 npm test
```

## Test File Structure

```text
public/
├── tests/
│   └── ui-tests.spec.js    # Main test file
├── js/
│   ├── app.js             # Application logic
│   ├── components.js      # UI components
│   └── router.js          # Routing
├── css/
│   ├── main.css          # Main styles
│   └── components.css     # Component styles
└── index.html            # Entry point
```

## Expected Results

### Successful Test Run

```text
✓ 20 tests passed (30s)
```

### Test Results Location

- HTML Report: `test-results/html-report/index.html`
- JSON Report: `test-results/test-results.json`
- Traces: `test-results/traces/`
- Videos: `test-results/videos/`

## Troubleshooting

### Port Already in Use

```bash
# Find and kill process on port 3000
# Windows
netstat -ano | findstr :3000
taskkill /PID <PID> /F

# Linux/Mac
lsof -i :3000
kill -9 <PID>
```

### Browser Installation Fails

```bash
# Install specific browsers
npx playwright install chromium
npx playwright install firefox
npx playwright install webkit
```

### Tests Timeout

Increase timeout in `playwright.config.js`:

```javascript
use: {
  actionTimeout: 30000,
  navigationTimeout: 60000,
}
```

## Adding New Tests

### Example: Adding a New Page Test

```javascript
// public/tests/ui-tests.spec.js

test('Navigate to New Page', async ({ page }) => {
  await page.click('a[href="#new-page"]');
  
  const pageTitle = page.locator('.page-title');
  await expect(pageTitle).toContainText('New Page');
  
  const content = page.locator('.page-content');
  await expect(content).toBeVisible();
});
```

## CI Integration

### GitHub Actions Example

```yaml
# .github/workflows/ui-tests.yml
name: UI Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
      - run: npm install
      - run: npm run test:install
      - run: npm test
```

## Supported Browsers

| Browser | Status |
| --------- | -------- |
| Chrome/Chromium | ✅ Supported |
| Firefox | ✅ Supported |
| Safari/WebKit | ✅ Supported |
| Mobile Chrome | ✅ Supported |
| Mobile Safari | ✅ Supported |

## Contact

For issues or questions about UI testing, please refer to the main documentation or open an issue in the repository.
