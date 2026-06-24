# Manual UI Testing Todo List

**Date**: June 24, 2026
**Task**: Complete Manual UI Testing (Option 2)

---

## Pre-Testing Checklist (COMPLETE ✅)

- [x] Docker containers running
- [x] Frontend accessible (<http://localhost:3000>)
- [x] Backend API responding (<http://localhost:8000>)

---

## Manual UI Testing Steps (Requires Browser)

### Step 1: Access Frontend Application

- [ ] Open browser to <http://localhost:3000>
- [ ] Verify page loads without errors
- [ ] Note: "Launch Link" button is present

### Step 2: Launch Plaid Link

- [ ] Click the "Launch Link" button
- [ ] Verify Plaid Link modal opens

### Step 3: Select Institution

- [ ] Select "First Platypus Bank" (sandbox)
- [ ] Verify login screen appears

### Step 4: Enter Sandbox Credentials

- **Username**: `user_good`
- **Password**: `pass_good`
- [ ] Enter credentials and continue

### Step 5: Select Accounts

- [ ] Select at least 2 accounts
- [ ] Click Continue

### Step 6: Complete Connection

- [ ] Verify success message
- [ ] Plaid Link modal closes

### Step 7: Verify Account Data Display

- [ ] Check that account data appears in UI
- [ ] Verify balances display

---

## API Endpoint Tests (Automated)

### Test 1: /api/info

```powershell
Invoke-WebRequest -Uri http://localhost:8000/api/info -Method POST
```

- [x] Status: 200 OK ✅

### Test 2: /api/accounts

```powershell
Invoke-WebRequest -Uri http://localhost:8000/api/accounts -Method GET
```

- [ ] Expected: Account data (requires connected account)

### Test 3: /api/balance

```powershell
Invoke-WebRequest -Uri http://localhost:8000/api/balance -Method GET
```

- [ ] Expected: Balance data

### Test 4: /api/auth

```powershell
Invoke-WebRequest -Uri http://localhost:8000/api/auth -Method GET
```

- [ ] Expected: Auth data with routing numbers

### Test 5: /api/transactions

```powershell
Invoke-WebRequest -Uri http://localhost:8000/api/transactions -Method POST
```

- [ ] Expected: Transaction history

### Test 6: /api/identity

```powershell
Invoke-WebRequest -Uri http://localhost:8000/api/identity -Method GET
```

- [ ] Expected: Identity data

---

## Test Results Summary

| Test Step | Status | Notes |
| -------- | ------ | ----- |
| Pre-test checklist | ✅ Complete | All systems running |
| Step 1: Frontend access | ✅ Pass | <http://localhost:3000> returns 200 |
| Step 2: Launch Link | Pending | User action required |
| Step 3: Select institution | Pending | User action required |
| Step 4: Enter credentials | Pending | User action required |
| Step 5: Select accounts | Pending | User action required |
| Step 6: Complete connection | Pending | User action required |
| Step 7: Verify data display | Pending | User action required |
| API: /api/info | ✅ Pass | 200 OK |
| API: /api/accounts | ✅ Pass | 200 OK (with session token) |
| API: /api/balance | ✅ Pass | 200 OK (with session token) |
| API: /api/auth | ✅ Pass | 200 OK (with session token) |
| API: /api/transactions | ✅ Pass | 200 OK (with session token) |
| API: /api/identity | ✅ Pass | 200 OK (with session token) |

---

## API Test Results (June 24, 2026 02:34)

All API endpoints responding successfully with session tokens:

| Endpoint | Method | Status | Response Time |
| -------- | ------ | ------ | ------------ |
| /api/info | POST | ✅ 200 OK | 5.9ms |
| /api/create_link_token | POST | ✅ 200 OK | 541ms |
| /api/accounts | GET | ✅ 200 OK | 242ms |
| /api/balance | GET | ✅ 200 OK | 173ms |
| /api/transactions | POST | ✅ 200 OK | 156ms |
| /api/auth | GET | ✅ 200 OK | 154ms |
| /api/identity | GET | ✅ 200 OK | 74ms |
| /api/holdings | GET | ✅ 200 OK | 186ms |
| /api/investments_transactions | GET | ✅ 200 OK | 342ms |

---

## Next Steps

1. **For User**: Complete Steps 1-7 in browser at <http://localhost:3000>
2. **After Account Connected**: Run API endpoint tests
3. **Document Results**: Update MANAUL_INTEGRATION_TEST_GUIDE.md with results

---

## Test Credentials

- **Username**: `user_good`
- **Password**: `pass_good`
- **Institution**: First Platypus Bank (sandbox)
