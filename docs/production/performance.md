# Performance Monitoring

## Lighthouse Check (after every deployment)

1. Open Chrome DevTools (F12)
2. Go to Lighthouse tab
3. Select: Performance, Accessibility, Best Practices, SEO
4. Generate Report for both Mobile and Desktop
5. **Target: Score > 90** in all categories

## Common Performance Issues

### Unoptimized Images
- Use your framework's image optimization component if available
- Serve images in modern formats (WebP, AVIF)
- Lazy-load images below the fold
- Specify explicit width/height to prevent layout shifts

### Large JavaScript Bundle
Use code splitting and dynamic/lazy imports for heavy components that aren't needed on initial load. Most modern frameworks support this out of the box.

### Missing Loading States
Always show feedback during data fetching — use skeleton components, spinners, or progress indicators from your component library.

### No Caching Strategy
Cache slow database queries and rarely-changing data using your framework's caching mechanism. See [database-optimization.md](database-optimization.md) for details.

## Quick Wins Checklist
- [ ] Images optimized (modern formats, lazy loading, explicit dimensions)
- [ ] Heavy components use code splitting / dynamic imports
- [ ] Loading states show skeleton/spinner
- [ ] Fonts loaded efficiently (preload, swap, or framework font optimization)
- [ ] Minimal client-side JavaScript (server-render where possible)

## Automated Monitoring
Consider using your deployment platform's built-in analytics or a dedicated performance monitoring service (e.g. Core Web Vitals tracking, real user monitoring).
