# Phase 1 & 2 Execution TODO

**Date**: January 28, 2026  
**Objective**: Complete Phase 1 (Production Deployment - remaining) and Phase 2 (Manual UI Testing)

---

## Phase 1: Production Deployment - Remaining Tasks

### Task 1.1: Deploy to Fly.io ✅ CONFIG COMPLETE

- [x] Update fly.toml with Owlban Group branding (app = "owlban-group")
- [ ] Attempt deployment with flyctl CLI (requires credit card)
- [ ] Set up environment variables
- [ ] Configure health checks passed

**Config Ready**:

- `fly.toml` - UPDATED (app = "owlban-group", port 8000, health check /api/health)

**Prerequisite**: Credit card required (per NEXT_PHASE_TODO.md)

### Task 1.2: Deploy to Render.com ✅ CONFIG COMPLETE

- [x] Update render.yaml with Owlban Group branding (name = "owlban-group")
- [ ] Connect GitHub repository to Render
- [ ] Deploy using render.yaml configuration
- [ ] Set up environment variables
- [ ] Verify deployment

**Config Ready**:

- `render.yaml` - UPDATED (name = "owlban-group", web service, docker, free plan)

---

## Phase 2: Manual UI Testing - Execute Checklist

### Task 2.1: Start Development Server

- [ ] Configure Plaid credentials in .env.local
- [ ] Start Python Flask server on port 8000

### Task 2.2: Execute Manual Testing Checklist

- [ ] Navigate to <http://localhost:8000>
- [ ] Verify dashboard loads correctly
- [ ] Click "Launch Link" button
- [ ] Interact with Plaid Link modal
- [ ] Select institution (use "Platypus" for sandbox)
- [ ] Enter credentials (user_good / pass_good)
- [ ] Select accounts
- [ ] Complete connection flow
- [ ] Verify data displays correctly

### Task 2.3: Document Results

- [ ] Record test results in TESTING_REPORT.md
- [ ] Note any issues encountered

---

## Execution Status

### Pre-Flight Check

- [x] Docker installed ✅
- [x] Configuration files updated with Owlban branding ✅
- [ ] Flyctl CLI installed ⏳
- [ ] Credit card on file for Fly.io ⏳

### Today Completed

- ✅ fly.toml updated: app = "owlban-group"
- ✅ render.yaml updated: name = "owlban-group"  
- ✅ deploy-to-platforms.ps1 updated: $APP_NAME = "owlban-group"
- ✅ PHASE1_2_TODO.md updated with branding changes

### Current Status

- Phase 1: Configuration complete, awaits CLI deployment
- Phase 2: Server requires Plaid credentials to start
