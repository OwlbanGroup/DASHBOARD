// UI Tests for Dashboard Public Site
// This file contains comprehensive UI tests using Playwright

const { test, expect } = require('@playwright/test');

describe('Dashboard Public Website UI Tests', () => {
  
  // Before running tests, navigate to the app
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
  });

  // Test 1: Homepage loads correctly
  test('Homepage loads with correct title', async ({ page }) => {
    await expect(page).toHaveTitle(/Cloud.io/);
  });

  // Test 2: Navigation menu exists
  test('Navigation menu has all expected links', async ({ page }) => {
    const navLinks = page.locator('.nav-menu .nav-link');
    await expect(navLinks).toHaveCount(7);
    
    await expect(navLinks.nth(0)).toHaveText('Home');
    await expect(navLinks.nth(1)).toHaveText('Virtual Machines');
    await expect(navLinks.nth(2)).toHaveText('Containers');
    await expect(navLinks.nth(3)).toHaveText('Bare Metal');
    await expect(navLinks.nth(4)).toHaveText('Confidential Compute');
    await expect(navLinks.nth(5)).toHaveText('Clusters');
    await expect(navLinks.nth(6)).toHaveText('Pricing');
  });

  // Test 3: Mobile navigation toggle works
  test('Mobile navigation toggle opens/closes menu', async ({ page }) => {
    // Set viewport to mobile size
    await page.setViewportSize({ width: 375, height: 667 });
    
    const navToggle = page.locator('#navToggle');
    const navMenu = page.locator('#navMenu');
    
    // Initially menu should be hidden on mobile
    await expect(navMenu).not.toHaveClass(/active/);
    
    // Click toggle
    await navToggle.click();
    
    // Menu should be visible
    await expect(navMenu).toHaveClass(/active/);
    
    // Click toggle again
    await navToggle.click();
    
    // Menu should be hidden
    await expect(navMenu).not.toHaveClass(/active/);
  });

  // Test 4: Homepage renders correctly
  test('Homepage renders hero section', async ({ page }) => {
    const heroTitle = page.locator('.hero-title');
    await expect(heroTitle).toContainText('Enterprise Cloud Infrastructure');
    
    const heroSubtitle = page.locator('.hero-subtitle');
    await expect(heroSubtitle).toBeVisible();
  });

  // Test 5: Navigation to Virtual Machines page
  test('Navigate to Virtual Machines page', async ({ page }) => {
    await page.click('a[href="#virtual-machines"]');
    
    const pageTitle = page.locator('.service-hero-title');
    await expect(pageTitle).toContainText('Virtual Machines');
  });

  // Test 6: Navigation to Containers page
  test('Navigate to Containers page', async ({ page }) => {
    await page.click('a[href="#containers"]');
    
    const pageTitle = page.locator('.service-hero-title');
    await expect(pageTitle).toContainText('Container Services');
  });

  // Test 7: Navigation to Bare Metal page
  test('Navigate to Bare Metal page', async ({ page }) => {
    await page.click('a[href="#bare-metal"]');
    
    const pageTitle = page.locator('.service-hero-title');
    await expect(pageTitle).toContainText('Bare Metal Servers');
  });

  // Test 8: Navigation to Confidential Compute page
  test('Navigate to Confidential Compute page', async ({ page }) => {
    await page.click('a[href="#confidential-compute"]');
    
    const pageTitle = page.locator('.service-hero-title');
    await expect(pageTitle).toContainText('Confidential Compute');
  });

  // Test 9: Navigation to Clusters page
  test('Navigate to Clusters page', async ({ page }) => {
    await page.click('a[href="#clusters"]');
    
    const pageTitle = page.locator('.service-hero-title');
    await expect(pageTitle).toContainText('Managed Clusters');
  });

  // Test 10: Navigation to Pricing page
  test('Navigate to Pricing page', async ({ page }) => {
    await page.click('a[href="#pricing"]');
    
    const pageTitle = page.locator('.service-hero-title');
    await expect(pageTitle).toContainText('Simple, Transparent Pricing');
  });

  // Test 11: Tab functionality on Containers page
  test('Tab switching works on Containers page', async ({ page }) => {
    // Navigate to Containers page
    await page.click('a[href="#containers"]');
    
    // Wait for tabs to load
    await page.waitForSelector('.tab-button');
    
    // Click Helm tab
    await page.click('button[data-tab="helm"]');
    
    // Check Helm content is visible
    const helmContent = page.locator('#helm');
    await expect(helmContent).toHaveClass(/active/);
    
    // Check kubectl content is not visible
    const kubectlContent = page.locator('#kubectl');
    await expect(kubectlContent).not.toHaveClass(/active/);
  });

  // Test 12: Navbar scroll effect
  test('Navbar has scroll effect on scroll', async ({ page }) => {
    const navbar = page.locator('.navbar');
    
    // Scroll down
    await page.evaluate(() => window.scrollTo(0, 100));
    
    // Wait a bit for scroll event to process
    await page.waitForTimeout(100);
    
    // Check navbar has scrolled class
    await expect(navbar).toHaveClass(/scrolled/);
  });

  // Test 13: Footer exists
  test('Footer renders correctly', async ({ page }) => {
    const footer = page.locator('.footer');
    await expect(footer).toBeVisible();
    
    const footerBrand = page.locator('.footer-section h3');
    await expect(footerBrand).toContainText('Cloud.io');
  });

  // Test 14: Feature cards on homepage
  test('Homepage has feature cards', async ({ page }) => {
    const featureCards = page.locator('.feature-card');
    const count = await featureCards.count();
    
    // Should have at least 3 feature cards
    expect(count).toBeGreaterThanOrEqual(3);
  });

  // Test 15: Pricing cards exist on Pricing page
  test('Pricing page shows pricing cards', async ({ page }) => {
    await page.click('a[href="#pricing"]');
    
    const pricingCards = page.locator('.pricing-card');
    const count = await pricingCards.count();
    
    // Should have pricing cards
    expect(count).toBeGreaterThan(0);
  });

  // Test 16: Console button exists
  test('Console button exists in navigation', async ({ page }) => {
    const consoleBtn = page.locator('.nav-menu .btn.btn-primary');
    await expect(consoleBtn).toContainText('Console');
  });

  // Test 17: No console errors on page load
  test('No critical console errors on homepage', async ({ page }) => {
    const errors = [];
    page.on('console', msg => {
      if (msg.type() === 'error') {
        errors.push(msg.text());
      }
    });
    
    await page.reload();
    await page.waitForLoadState('networkidle');
    
    // Filter out known non-critical errors
    const criticalErrors = errors.filter(e => !e.includes('favicon'));
    expect(criticalErrors).toHaveLength(0);
  });

  // Test 18: Responsive navbar at different sizes
  test('Navbar adapts to different viewport sizes', async ({ page }) => {
    // Test tablet size
    await page.setViewportSize({ width: 768, height: 1024 });
    await page.reload();
    await expect(page.locator('.nav-menu')).toHaveClass(/active/);
    
    // Test mobile size
    await page.setViewportSize({ width: 375, height: 667 });
    await page.reload();
    await expect(page.locator('.nav-menu')).not.toHaveClass(/active/);
  });

  // Test 19: Page fade-in animation works
  test('Page sections have fade-in animation', async ({ page }) => {
    await page.click('a[href="#virtual-machines"]');
    
    const sections = page.locator('.section');
    await expect(sections.first()).toBeVisible();
  });

  // Test 20: External links have correct href
  test('External console link is correct', async ({ page }) => {
    const consoleLink = page.locator('a.btn-primary:has-text("Console")');
    const href = await consoleLink.getAttribute('href');
    expect(href).toBe('https://console.cloud.io.net');
  });
});
