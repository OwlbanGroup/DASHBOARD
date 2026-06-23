# Python Diagnostic Fix TODO

## Issues to Fix in server.py

### 1. Employment/Payroll Endpoints (lines 549, 568)

- Replace client.employment_get() with client.employment_verification_get()
- Replace EmploymentGetRequest with appropriate request class
- Status: TODO

### 2. Variable Assignment Issues in CRA Endpoints

- Fix base_report_request, pdf_request, partner_request initialization
- Status: TODO

### 3. Unused Imports

- Remove TransferGetRequest (line 54)
- Remove TransferCreateIdempotencyKey (line 59)
- Status: TODO

### 4. Global Variable Initialization Issues

- Add proper initial values for authorization_id, account_id at module level
- Status: TODO

### 5. Testing

- Verify fixes resolve diagnostic errors
- Status: TODO
