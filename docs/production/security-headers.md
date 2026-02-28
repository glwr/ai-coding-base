# Security Headers Configuration

Protect against XSS, Clickjacking, MIME sniffing, and other common web attacks.

## Required Headers

Configure these headers in your framework's configuration or web server:

| Header | Value | Protection |
|--------|-------|-----------|
| X-Frame-Options | DENY | Prevents your site from being embedded in iframes (clickjacking) |
| X-Content-Type-Options | nosniff | Prevents browsers from guessing content types (MIME sniffing) |
| Referrer-Policy | origin-when-cross-origin | Controls how much URL info is sent to other sites |
| Strict-Transport-Security | max-age=31536000; includeSubDomains | Forces HTTPS connections |

## How to Set Headers

Most frameworks provide a way to set response headers globally:
- **Config file:** Add headers in your framework's config (e.g. next.config, nuxt.config, etc.)
- **Middleware:** Set headers in a middleware function that runs on every request
- **Web server:** Configure headers in nginx, Apache, or your reverse proxy
- **CDN/Platform:** Some deployment platforms allow setting headers in their configuration

Choose the approach that fits your stack. The important thing is that ALL responses include these headers.

## Verify After Deployment
1. Open Chrome DevTools
2. Go to Network tab
3. Click on any request to your site
4. Check Response Headers section
5. Verify all 4 headers are present

## Advanced (Optional)
**Content-Security-Policy (CSP)** — The most powerful header, but can break your app if misconfigured. Only add after thorough testing.

Start with report-only mode first: `Content-Security-Policy-Report-Only`
