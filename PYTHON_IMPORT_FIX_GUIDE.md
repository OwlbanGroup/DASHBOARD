# Python Import Fix Guide - Diagnostic Resolution

## Issue Summary

Fix VSCode Pylint/Pylance/Mypy errors for Plaid SDK v15+ imports in server.py

## Root Cause

The file imports models that may not exist in older Plaid SDK versions, but the errors appear because:

1. Pylance can't find type stubs for some modules
2. The import names don't match the actual SDK module structure

## Solution Approach

### Option 1: Add Conditional Imports (Recommended)

Wrap optional imports in try-except blocks:

```python
# Statements API - available in Plaid SDK v15+ 
try:
    from plaid.model.statements_list_request import StatementsListRequest
    from plaid.model.statements_download_request import StatementsDownloadRequest
except ImportError:
    StatementsListRequest = None
    StatementsDownloadRequest = None

# CRA models - available in Plaid SDK v15+
try:
    from plaid.model.cra_check_report_base_report_get_request import CraCheckReportBaseReportGetRequest
except ImportError:
    CraCheckReportBaseReportGetRequest = None
```

### Option 2: Configure Pylance/Pylint

Add to VSCode settings or create `pyproject.toml`:

```toml
[tool.mypy]
ignore_missing_imports = true

[tool.pylint]
extension-pkg-allow-list = ["plaid"]
```

### Option 3: Fix the Underlying Import Issues

The diagnostic errors show imports that can't be resolved. Check:

1. Plaid SDK version: `pip show plaid-python`
2. Available models: `python -c "from plaid import model; print(dir(model))"`

## Implementation Steps

### Step 1: Check SDK Version

```bash
pip show plaid-python
```

Expected: `Version: 38.0.0` or higher (full v15+ support)

### Step 2: Add Type Hints Configuration

Create `quickstart/python/pyproject.toml`:

```toml
[tool.pyright]
include = ["server.py"]
executionEnvironments = [{"pythonVersion": "3.11"}]

[tool.mypy]
python_version = "3.11"
ignore_missing_imports = true

[tool.pylint]
extension-pkg-allow-list = ["plaid"]
```

### Step 3: Update Imports

Add try-except blocks for optional imports (SDK v15+ features)

## Files to Modify

1. `quickstart/python/server.py` - Add conditional imports
2. Create `quickstart/python/pyproject.toml` - Type configuration

## Verification

After fix, VSCode should show:

- No "import-error" or "no-name-in-module" errors
- Only info-level mypy notes about missing stubs
- Code runs correctly with Plaid API
