# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to deprecated APIs or nullable reference types, as these may indicate areas that need attention.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it references `Microsoft.AspNetCore.App` or the appropriate framework.

### 4. Run the Application Locally

Start the application locally to verify it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key functionality to confirm behavior matches the legacy version.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review any failing tests and determine whether they reflect genuine regressions or tests that require updating due to the migration.

### 6. Check for Removed or Changed APIs

Review any usage of APIs that were available in the .NET Framework but have changed or been removed in cross-platform .NET. Pay particular attention to:

- `System.Web` dependencies, which are not available in cross-platform .NET
- Windows-specific APIs such as the registry, WCF, or `System.Drawing` (GDI+)
- Any third-party libraries that may have platform-specific builds

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformCompat.Analyzer` NuGet package to surface remaining compatibility issues.

### 7. Verify Configuration

Ensure that configuration files have been correctly migrated. In cross-platform .NET, `Web.config` and `App.config` are replaced by `appsettings.json`. Confirm that:

- All connection strings are present in `appsettings.json`
- Application settings have been moved appropriately
- Environment-specific configuration files (e.g., `appsettings.Development.json`) are in place

### 8. Validate Static Files and Middleware

If this is a web application, confirm that static file serving, routing, and middleware are configured correctly in `Program.cs` or `Startup.cs`, as the pipeline differs significantly from the legacy `System.Web` model.

### 9. Publish the Application

Once local validation is complete, publish the application to verify the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files are present before deploying to the target environment.