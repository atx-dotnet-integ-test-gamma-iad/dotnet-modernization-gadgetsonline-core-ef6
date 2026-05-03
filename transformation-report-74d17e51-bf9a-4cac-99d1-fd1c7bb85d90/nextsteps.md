# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Run the following command from the solution root to ensure all dependencies are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Verify that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate and supported version, such as `net8.0`. Ensure no legacy `<TargetFrameworkVersion>` elements remain from the old `.csproj` format.

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality to confirm runtime behavior matches the pre-migration state.

### 5. Run Existing Tests

If a test project exists in the solution, execute the test suite:

```bash
dotnet test
```

Review the results and address any failing tests that may indicate behavioral regressions introduced during the migration.

### 6. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that were available in the legacy .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` references, which are not available in cross-platform .NET
- `HttpContext` and related types if this is a web application
- Windows-specific APIs such as the registry, WCF server-side components, or `System.Drawing` without the compatibility package
- Configuration APIs (`ConfigurationManager`) which may require the `System.Configuration.ConfigurationManager` NuGet package

### 7. Validate Configuration Files

Ensure that `appsettings.json` or equivalent configuration files are present and correctly structured if the project previously relied on `Web.config` or `App.config`. Confirm that connection strings, application settings, and environment-specific values have been carried over correctly.

### 8. Verify Static Assets and Views

If this is a web application, confirm that all views, static files, and wwwroot content are present and accessible at runtime. Check that the project file includes the necessary entries for content and static assets.

### 9. Test Against a Target Database

If the application uses a database, run the application against a test instance and verify that:

- Connections are established successfully
- Queries execute without error
- Any Entity Framework migrations are up to date by running:

```bash
dotnet ef database update
```

### 10. Review Event and Application Logs

After running the application, review the console output and any log files for runtime exceptions or warnings that would not surface during a build but could indicate incomplete migration work.