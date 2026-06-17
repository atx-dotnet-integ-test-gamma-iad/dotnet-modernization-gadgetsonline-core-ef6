# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation

### 1. Restore Dependencies

Run the following command from the solution root to confirm all NuGet packages resolve correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent:

```bash
dotnet build --configuration Release
```

Check the output for any warnings that, while non-breaking, may indicate deprecated APIs or compatibility concerns that could cause runtime issues.

### 3. Run Unit Tests

If the solution contains any test projects, execute them to verify runtime behavior has not regressed:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether they are caused by behavioral differences in the new runtime or by test setup issues related to the migration.

### 4. Review Replaced or Removed APIs

Inspect the codebase for any APIs that were commonly replaced during legacy migrations, including:

- `System.Web` references (e.g., `HttpContext`, `HttpRequest`) — these do not exist in cross-platform .NET and may have been stubbed or replaced during transformation.
- `ConfigurationManager` usage — confirm that configuration has been migrated to `Microsoft.Extensions.Configuration` or that the `System.Configuration.ConfigurationManager` NuGet package has been added.
- `EntityFramework` (non-Core) — if the project used EF 6, confirm whether it was migrated to EF Core or if the `EntityFramework` NuGet package targeting .NET is being used.

### 5. Verify Application Configuration

Check that `appsettings.json` (or equivalent) contains all configuration values that previously existed in `Web.config` or `App.config`. Confirm that connection strings, application settings, and any custom configuration sections have been carried over correctly.

### 6. Test Application Startup

Run the application locally and verify it starts without runtime exceptions:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the core application flows, particularly any areas that interact with the database, external services, or authentication, as these are common points of failure after migration.

### 7. Review Static Files and Web Assets

If this is a web project, confirm that static files (CSS, JavaScript, images) are being served correctly. In cross-platform .NET web projects, static files must be placed in the `wwwroot` folder and the middleware must be configured with `app.UseStaticFiles()` in the startup pipeline.

### 8. Check Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If a newer LTS version of .NET is available and desired, update this value and re-run the restore and build steps above.