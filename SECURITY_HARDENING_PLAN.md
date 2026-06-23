# Security Hardening Plan

## Executive Summary

This document outlines security hardening measures to protect the financial dashboard from common vulnerabilities and attacks.

## Current Baseline Security Analysis

### Files Analyzed

- `nginx.conf` - Web server configuration
- `Dockerfile` - Container build configuration  
- `quickstart/python/server.py` - Backend API server
- `quickstart/node/package.json` - Node.js dependencies
- `.gitignore` - File exclusion rules
- `.github/workflows/deploy-simple.yml` - CI/CD pipeline

### Security Controls Found

✅ `.gitignore` - Excludes secrets, credentials, banking details, keys
✅ Security headers in nginx.conf
✅ Rate limiting in Python server
✅ Security libraries included (helmet, bcryptjs, jsonwebtoken)

### Critical Vulnerabilities Identified

| ID | Severity | Finding | Location |
|----|----------|---------|----------|
| V1 | CRITICAL | Hardcoded admin password | Dockerfile |
| V2 | HIGH | Missing Content Security Policy | nginx.conf |
| V3 | HIGH | Missing HSTS header | nginx.conf |
| V4 | MEDIUM | In-memory token storage | server.py |
| V5 | MEDIUM | Missing security headers | nginx.conf |
| V6 | LOW | No explicit TLS enforced | server.py |

---

## Hardening Measures

### 1. Fix Hardcoded Password (V1)

**Location**: `Dockerfile`
**Action**: Remove hardcoded password, require via environment variable
**Priority**: CRITICAL

### 2. Enhance Security Headers (V2, V3, V5)

**Location**: `nginx.conf`
**Actions**:
- Add Content-Security-Policy header
- Add Strict-Transport-Security (HSTS) header  
- Add Permissions-Policy header
- Add Cross-Origin-Embedder-Policy
- Add Cross-Origin-Opener-Policy

### 3. Security Improvements (V4, V6)

**Location**: `quickstart/python/server.py`
**Actions**:
- Add JWT token expiry
- Add secure session configuration
- Add CSRF token support

### 4. Additional Nginx Hardening

**Actions**:
- Enable TLS 1.3 only
- Configure secure ciphers
- Add rate limiting
- Enable OCSP stapling (for production)

---

## Implementation Checklist

- [x] 1. Fix Dockerfile hardcoded password → ✅ COMPLETED
- [x] 2. Update nginx.conf with enhanced security headers → ✅ COMPLETED  
- [x] 3. Add CSP header configuration → ✅ COMPLETED
- [x] 4. Add HSTS header (max-age: 1 year) → ✅ COMPLETED
- [x] 5. Add additional security headers → ✅ COMPLETED
- [ ] 6. Document required environment variables
- [ ] 7. Create security configuration guide

---

## Implementation Status

### ✅ Phase 1 Complete (January 2025)

**1. Dockerfile - CRITICAL fix applied:**
- Removed hardcoded `GF_SECURITY_ADMIN_PASSWORD=admin`
- Added: Disabled anonymous auth, disabled login form
- Added security comments documenting runtime injection requirement

**2. nginx.conf - HIGH priority security headers:**
- Added Content-Security-Policy (CSP)
- Added Strict-Transport-Security (HSTS) with 1-year max-age  
- Added Permissions-Policy
- Added Cross-Origin policies (COEP, COOP, CORP)
- Upgraded X-Frame-Options from SAMEORIGIN to DENY

---

## Required Environment Variables

After hardening, the following environment variables MUST be configured:

```
# Required for Production
GF_SECURITY_ADMIN_PASSWORD=<secure-random-password>
PLAID_CLIENT_ID=<your-client-id> 
PLAID_SECRET=<your-secret>

# Optional but Recommended
PLAID_REDIRECT_URI=https://your-domain.com/oauth
JWT_SECRET=<minimum-32-character-random-string>
```

---

## Security Headers Reference

### Recommended Nginx Security Headers

```
# Frame Protection
add_header X-Frame-Options "DENY" always;

# MIME Type Protection  
add_header X-Content-Type-Options "nosniff" always;

# XSS Protection
add_header X-XSS-Protection "1; mode=block" always;

# Referrer Policy
add_header Referrer-Policy "strict-origin-when-cross-origin" always;

# Content Security Policy (CSP)
add_header Content-Security-Policy "default-src 'self'; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline'; img-src 'self' data:; font-src 'self';" always;

# HSTS - Enforce HTTPS
add_header Strict-Transport-Security "max-age=31536000; includeSubDomains; preload" always;

# Permissions Policy
add_header Permissions-Policy "geolocation=(), microphone=(), camera=()" always;

# Cross-Origin Policies  
add_header Cross-Origin-Embedder-Policy "require-corp" always;
add_header Cross-Origin-Opener-Policy "same-origin" always;
add_header Cross-Origin-Resource-Policy "same-origin" always;
```

---

## Timeline

- **Phase 1 (Immediate)**: Fix critical vulnerability V1 (hardcoded password)
- **Phase 2 (This Week)**: Implement V2, V3, V5 (enhanced headers)
- **Phase 3 (Next Week)**: Document and test security configurations

---

## Validation

After implementation, verify:

1. Run security header scan: `nmap --script http-security-headers -p 80,443 localhost`
2. Check for exposed secrets: `grep -r "password\|secret\|key" --include="*.py" .`
3. Verify no hardcoded values in Docker: `docker inspect <image>`

---

## References

- OWASP Security Headers: https://owasp.org/www-project-secure-headers/
- Mozilla TLS Guidelines: https://wiki.mozilla.org/Security/Server_Side_TLS
- CIS Docker Benchmark: https://www.cisecurity.org/benchmark/docker

---

**Last Updated:** January 2025  
**Status:** Plan Ready for Implementation  
**Next Step:** Awaiting Approval to Proceed
