# Production Credentials Configuration Guide

This guide walks through configuring production credentials for the deployment.

## Production Environment Variables

### Plaid Credentials (Required)
```
PLAID_CLIENT_ID=your_production_client_id
PLAID_SECRET=your_production_secret
PLAID_ENV=production
```

### Products Configuration
```
PLAID_PRODUCTS=transactions,auth,identity
PLAID_COUNTRY_CODES=US
```

### Application URLs
```
APP_URL=https://your-production-domain.com
API_URL=https://your-api-domain.com
CORS_ORIGINS=https://your-production-domain.com
```

### Security Secrets (Required - Generate Strong Random Values)
```
SESSION_SECRET=generate_32_char_minimum_random_string
JWT_SECRET=generate_64_char_minimum_random_string
```

## How to Configure

### Option 1: Vercel Dashboard
1. Go to https://vercel.com
2. Navigate to your project
3. Settings → Environment Variables
4. Add each variable

### Option 2: Heroku Dashboard
1. Go to https://dashboard.heroku.com
2. Navigate to your app
3. Settings → Config Vars
4. Add each variable

### Option 3: Docker compose.prod.yml
Update environment section in docker-compose.prod.yml

### Option 4: Render.com Dashboard
1. Go to https://dashboard.render.com
2. Select your service
3. Environment tab
4. Add each variable

## Platform-Specific Configuration

### Vercel Configuration (vercel.json)
```json
{
  "build": {
    "env": {
      "PLAID_ENV": "production"
    }
  }
}
```

### Heroku Configuration (Procfile)
```
web: npm start
```

## Verification

After configuration, verify by checking:
1. API responds with correct environment
2. Plaid operations work in production mode
3. No sandbox-related errors in logs

## Next Steps
After setting up production credentials, proceed to:
- Set up monitoring (error tracking, uptime monitoring)
- Deploy to additional platforms (optional)
