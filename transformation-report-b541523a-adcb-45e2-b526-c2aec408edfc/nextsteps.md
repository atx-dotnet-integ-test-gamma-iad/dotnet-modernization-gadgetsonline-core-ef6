# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure the framework moniker is appropriate (e.g., `net8.0` rather than a Windows-specific TFM unless Windows-only APIs are required).

### 4. Run the Application Locally

Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the locally hosted URL provided in the console output and verify that the application loads and functions as expected.

### 5. Execute Tests

If the solution contains test projects, run them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and address any failing tests before proceeding.

### 6. Review Removed or Changed APIs

Cross-platform .NET does not support certain APIs that were available in .NET Framework. Check the following areas manually:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. Ensure any references have been replaced with ASP.NET Core equivalents.
- **Windows Registry or WCF usage**: These may require additional NuGet packages or alternative implementations.
- **`HttpContext` and related types**: Confirm these have been migrated to their ASP.NET Core counterparts.

The [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) can assist in identifying remaining compatibility issues.

### 7. Check Runtime Behavior

Even when a project builds successfully, runtime issues can exist. Specifically:

- Test all major user-facing workflows in the application.
- Verify database connectivity and that any Entity Framework migrations are compatible with the new runtime.
- Confirm that configuration files (e.g., `appsettings.json`) are being read correctly, as `web.config`-based configuration is not used in cross-platform .NET by default.

### 8. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and confirm all expected files are present before deploying to the target environment.