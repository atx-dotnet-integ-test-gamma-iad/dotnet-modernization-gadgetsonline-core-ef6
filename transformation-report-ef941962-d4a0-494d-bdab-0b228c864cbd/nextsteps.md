# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or version mismatches, particularly packages that may have been targeting the legacy .NET Framework.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Verify that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Replaced or Removed APIs

Check the codebase for any usage of APIs that were available in the legacy .NET Framework but behave differently in cross-platform .NET, such as:

- `System.Web` references (not available in cross-platform .NET)
- `HttpContext`, `HttpRequest`, or `HttpResponse` legacy usages
- `ConfigurationManager` (requires the `System.Configuration.ConfigurationManager` NuGet package)
- Windows-specific APIs (registry access, Windows identity, etc.)

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to confirm baseline functionality is intact.

### 5. Run Existing Tests

If a test project exists in the solution, execute the test suite:

```bash
dotnet test
```

Review test results and address any failing tests that may indicate behavioral differences between the legacy and modernized versions.

### 6. Verify Configuration Files

- Confirm that `appsettings.json` (or `appsettings.Development.json`) contains all settings previously held in `Web.config` or `App.config`.
- Ensure connection strings, application keys, and environment-specific settings have been correctly migrated.
- Remove or archive any legacy `Web.config` or `App.config` files that are no longer in use.

### 7. Check Static Files and wwwroot

If this is a web application, verify that static assets (CSS, JavaScript, images) have been placed under the `wwwroot` folder, which is the expected location in ASP.NET Core.

### 8. Validate Database Connectivity

If the application uses a database, confirm that:

- The connection string in `appsettings.json` is correct.
- Any Entity Framework migrations are up to date by running:

```bash
dotnet ef database update
```

### 9. Test on Target Platform

If the goal of the migration was cross-platform support, test the application explicitly on the target operating system (Linux or macOS) to surface any remaining platform-specific issues.

### 10. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `TargetFramework` is set to the intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Update this value if a newer Long-Term Support (LTS) version of .NET is preferred.