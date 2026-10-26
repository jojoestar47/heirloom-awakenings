// Copy to config.js and fill in from your Neon Console → Data API page.
// Both are public client-side values (the anonymous-token endpoint needs no key).
window.NEON_DATA_API_URL = 'YOUR_NEON_DATA_API_URL';   // .../neondb/rest/v1
window.NEON_AUTH_URL     = 'YOUR_NEON_AUTH_URL';        // .../neondb/auth

// Admin page login (#/admin): username + SHA-256 hex of the password.
// Generate both from Admin → "Change admin username or password".
window.ADMIN_USERNAME        = 'dm';
window.ADMIN_PASSWORD_SHA256 = 'YOUR_PASSWORD_SHA256';
