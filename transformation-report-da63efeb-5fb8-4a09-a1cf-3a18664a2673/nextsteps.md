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

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure the appropriate SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Replaced APIs

Review the codebase for any usage of APIs that were available in .NET Framework but have been removed or altered in cross-platform .NET. Common areas to check include:

- `System.Web` references, which are not available in cross-platform .NET and should be replaced with `Microsoft.AspNetCore` equivalents.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages that may need to be updated.
- Any reliance on Windows-specific APIs such as the registry, WCF server-side components, or `System.Drawing` without a compatible replacement.

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and verify that core functionality behaves as expected, including routing, data access, and any authentication flows.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that existing behavior is preserved:

```bash
dotnet test
```

Review any failing tests and determine whether they indicate a regression introduced during migration or a test that requires updating to reflect the new framework.

### 7. Verify Database Connectivity

If the application uses Entity Framework or another data access layer, confirm that:

- The connection string in `appsettings.json` (or equivalent configuration file) is correct.
- Any pending migrations are applied:

```bash
dotnet ef database update
```

- The application can successfully read and write data at runtime.

### 8. Review Configuration Files

Confirm that configuration previously held in `Web.config` has been correctly migrated to `appsettings.json`. Pay particular attention to:

- Connection strings
- Application settings
- Any custom HTTP handlers or modules, which must be replaced with ASP.NET Core middleware

### 9. Test on Target Platform

If the goal is to run on a non-Windows platform such as Linux or macOS, run the application on that platform explicitly to surface any remaining platform-specific dependencies that may not have been caught during the build phase.