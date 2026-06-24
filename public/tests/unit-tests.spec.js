// Unit Tests for JavaScript Utility Functions and Components
// These tests verify the core JavaScript functions work correctly

const { test, expect } = require('@playwright/test');

describe('JavaScript Utility Functions', () => {
  
  // Setup: Inject utility functions into the page before each test
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
    
    // Inject the utility functions from app.js
    await page.addScriptTag({
      path: './public/js/app.js'
    });
  });

  // Test formatNumber function
  test('formatNumber formats numbers with commas', async ({ page }) => {
    const result = await page.evaluate(() => {
      return formatNumber(1000);
    });
    expect(result).toBe('1,000');
  });

  test('formatNumber handles larger numbers', async ({ page }) => {
    const result = await page.evaluate(() => {
      return formatNumber(1000000);
    });
    expect(result).toBe('1,000,000');
  });

  test('formatNumber handles edge case of zero', async ({ page }) => {
    const result = await page.evaluate(() => {
      return formatNumber(0);
    });
    expect(result).toBe('0');
  });

  test('formatNumber handles small numbers', async ({ page }) => {
    const result = await page.evaluate(() => {
      return formatNumber(100);
    });
    expect(result).toBe('100');
  });

  // Test formatCurrency function
  test('formatCurrency formats amount with dollar sign', async ({ page }) => {
    const result = await page.evaluate(() => {
      return formatCurrency(1000);
    });
    expect(result).toBe('$1,000');
  });

  test('formatCurrency handles larger amounts', async ({ page }) => {
    const result = await page.evaluate(() => {
      return formatCurrency(999999);
    });
    expect(result).toBe('$999,999');
  });

  test('formatCurrency handles zero amount', async ({ page }) => {
    const result = await page.evaluate(() => {
      return formatCurrency(0);
    });
    expect(result).toBe('$0');
  });
});

describe('Page Components', () => {
  
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
    await page.addScriptTag({
      path: './public/js/components.js'
    });
  });

  // Test that all component functions exist and return strings
  test('home component returns HTML string', async ({ page }) => {
    const html = await page.evaluate(() => {
      return components.home();
    });
    
    expect(html).toContain('Enterprise Cloud Infrastructure');
    expect(html).toContain('<section');
  });

  test('virtualMachines component returns HTML string', async ({ page }) => {
    const html = await page.evaluate(() => {
      return components.virtualMachines();
    });
    
    expect(html).toContain('Virtual Machines');
    expect(html).toContain('<section');
  });

  test('containers component returns HTML string', async ({ page }) => {
    const html = await page.evaluate(() => {
      return components.containers();
    });
    
    expect(html).toContain('Container Services');
    expect(html).toContain('<section');
  });

  test('bareMetal component returns HTML string', async ({ page }) => {
    const html = await page.evaluate(() => {
      return components.bareMetal();
    });
    
    expect(html).toContain('Bare Metal Servers');
    expect(html).toContain('<section');
  });

  test('confidentialCompute component returns HTML string', async ({ page }) => {
    const html = await page.evaluate(() => {
      return components.confidentialCompute();
    });
    
    expect(html).toContain('Confidential Compute');
    expect(html).toContain('<section');
  });

  test('clusters component returns HTML string', async ({ page }) => {
    const html = await page.evaluate(() => {
      return components.clusters();
    });
    
    expect(html).toContain('Managed Clusters');
    expect(html).toContain('<section');
  });

  test('pricing component returns HTML string', async ({ page }) => {
    const html = await page.evaluate(() => {
      return components.pricing();
    });
    
    expect(html).toContain('Simple, Transparent Pricing');
    expect(html).toContain('<section');
  });
});

describe('Router Functionality', () => {
  
  test('Router can be instantiated', async ({ page }) => {
    await page.goto('/');
    await page.addScriptTag({
      path: './public/js/router.js'
    });
    
    // Verify router exists
    const routerExists = await page.evaluate(() => {
      return typeof router !== 'undefined' && router !== null;
    });
    
    expect(routerExists).toBe(true);
  });

  test('Router has required methods', async ({ page }) => {
    await page.goto('/');
    await page.addScriptTag({
      path: './public/js/router.js'
    });
    
    // Check router has the expected methods
    const hasRegister = await page.evaluate(() => {
      return typeof router.register === 'function';
    });
    
    const hasHandleRoute = await page.evaluate(() => {
      return typeof router.handleRoute === 'function';
    });
    
    const hasNavigate = await page.evaluate(() => {
      return typeof router.navigate === 'function';
    });
    
    expect(hasRegister).toBe(true);
    expect(hasHandleRoute).toBe(true);
    expect(hasNavigate).toBe(true);
  });

  test('Router can register routes', async ({ page }) => {
    await page.goto('/');
    await page.addScriptTag({
      path: './public/js/router.js'
    });
    
    // Register a test route
    const registerResult = await page.evaluate(() => {
      router.register('test-route', () => {
        return 'test content';
      });
      return router.routes['test-route'] !== undefined;
    });
    
    expect(registerResult).toBe(true);
  });
});

describe('DOM Interactions', () => {
  
  test('App element exists in the DOM', async ({ page }) => {
    await page.goto('/');
    
    const appExists = await page.locator('#app').count();
    expect(appExists).toBe(1);
  });

  test('Navigation elements exist in the DOM', async ({ page }) => {
    await page.goto('/');
    
    const navMenuCount = await page.locator('#navMenu').count();
    const navToggleCount = await page.locator('#navToggle').count();
    
    expect(navMenuCount).toBe(1);
    expect(navToggleCount).toBe(1);
  });

  test('Navbar exists in the DOM', async ({ page }) => {
    await page.goto('/');
    
    const navbarCount = await page.locator('.navbar').count();
    expect(navbarCount).toBe(1);
  });
});

describe('Error Handling', () => {
  
  test('formatNumber handles negative numbers', async ({ page }) => {
    await page.goto('/');
    await page.addScriptTag({
      path: './public/js/app.js'
    });
    
    const result = await page.evaluate(() => {
      return formatNumber(-1000);
    });
    
    expect(result).toBe('-1,000');
  });

  test('Components handle empty state gracefully', async ({ page }) => {
    await page.goto('/');
    await page.addScriptTag({
      path: './public/js/components.js'
    });
    
    // All components should return non-empty strings
    const homeEmpty = await page.evaluate(() => {
      return components.home().length === 0;
    });
    
    expect(homeEmpty).toBe(false);
  });
});
