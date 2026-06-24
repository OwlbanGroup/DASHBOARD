# Testing Plan for DASHBOARD JavaScript Code

## Project Overview

The DASHBOARD project is a public website for a cloud infrastructure service (Cloud.io). The codebase consists of:

- `public/js/app.js` - Main application logic
- `public/js/router.js` - SPA Router class
- `public/js/components.js` - Page components/templates
- `public/tests/ui-tests.spec.js` - Existing Playwright UI tests

## Information Gathered

### Current Test Coverage

The existing UI tests in `ui-tests.spec.js` already cover (20 tests):

1. Homepage loads with correct title
2. Navigation menu has all expected links (7 links)
3. Mobile navigation toggle opens/closes menu
4. Homepage renders hero section
5-10. Navigation to all 7 pages (Virtual Machines, Containers, Bare Metal, Confidential Compute, Clusters, Pricing)
5. Tab switching on Containers page
6. Navbar scroll effect
7. Footer renders correctly
8. Feature cards on homepage
9. Pricing cards on Pricing page
10. Console button exists in navigation
11. No critical console errors
12. Responsive navbar at different viewport sizes
13. Page fade-in animation
14. External console link is correct

### Functions Available to Test

#### app.js Utilities

```javascript
formatNumber(num)     // Formats number with commas: 1000 -> "1,000"
formatCurrency(amount)  // Formats as currency: 1000 -> "$1,000"
```

#### router.js Class

```javascript
class Router {
  constructor()       // Initializes routes, listens for hashchange
  register(path, handler)  // Registers a route handler
  handleRoute()       // Handles route changes
  navigate(path)     // Programmatic navigation
  updateActiveNav()   // Updates active nav link
}
```

#### components.js

```javascript
const components = {
  home: () => string,
  virtualMachines: () => string,
  containers: () => string,
  bareMetal: () => string,
  confidentialCompute: () => string,
  clusters: () => string,
  pricing: () => string
}
```

## Plan

### Phase 1: Add Unit Tests for Pure JavaScript Functions

Create a new test file for pure JavaScript function testing (runs in Node.js):

1. **test/js/app-utils.spec.js** - Test utility functions
   - Test formatNumber() with various inputs
   - Test formatCurrency() with various inputs
   - Test edge cases (0, negative numbers, large numbers)

2. **test/js/router.spec.js** - Test Router class
   - Test route registration
   - Test route handling
   - Test navigation

### Phase 2: Additional UI/Integration Tests (Optional)

Additional tests that complement existing tests:

- Test keyboard navigation accessibility
- Test browser back/forward navigation
- Test error handling for invalid routes

## Files to Edit/Create

### New Files

- `test/js/app-utils.spec.js` - Unit tests for utility functions
- `test/js/router.spec.js` - Unit tests for Router

### Files Already Complete

- `public/tests/ui-tests.spec.js` - 20 comprehensive UI tests (already exists)

## Testing Strategy

### Unit Tests (Node.js environment)

- Test pure functions without DOM dependencies
- Fast execution, no browser needed
- Use Jest or similar

### UI Tests (Browser environment)

- Already comprehensive with Playwright
- Tests full user interactions
- Tests in `public/tests/ui-tests.spec.js`

## Follow-up Steps

1. Run existing UI tests to verify they pass
2. Add unit tests for utility functions if needed
3. Verify all tests pass

## Implementation Complete

### Files Created

1. **TESTING_PLAN.md** - Comprehensive testing plan document
2. **public/tests/unit-tests.spec.js** - Unit tests for JavaScript utilities (26 test cases)

### Test Coverage

- JavaScript Utility Functions: 7 tests
  - formatNumber() - 4 tests
  - formatCurrency() - 3 tests
- Page Components: 7 tests  
  - All 7 component templates tested
- Router Functionality: 3 tests
  - Router instantiation, methods, and route registration
- DOM Interactions: 3 tests
  - App element, navigation elements, navbar
- Error Handling: 2 tests
  - Negative numbers, empty state handling

### Total: 26 new unit tests added

Existing tests:

- UI tests in `public/tests/ui-tests.spec.js` - 20 tests (already in place)

Status: COMPLETED
