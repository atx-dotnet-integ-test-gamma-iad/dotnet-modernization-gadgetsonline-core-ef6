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

Confirm the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to your intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it references `net48` or any other legacy framework moniker, update it accordingly.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify that existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review the test output for any failures or skipped tests that may indicate compatibility issues introduced during the transformation.

### 5. Check for Removed or Changed APIs

Inspect the codebase for usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` references (not available in cross-platform .NET)
- `HttpContext` and related ASP.NET types (may require migration to ASP.NET Core equivalents)
- Windows-specific APIs such as the registry, WMI, or Windows Communication Foundation (WCF)
- `ConfigurationManager` (requires the `System.Configuration.ConfigurationManager` NuGet package)

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.ApiCompat` tooling to surface any remaining compatibility issues.

### 6. Verify Configuration Files

Confirm that any `App.config` or `Web.config` files have been migrated to the appropriate `appsettings.json` format expected by cross-platform .NET. Ensure that connection strings, application settings, and middleware configuration are correctly represented.

### 7. Run the Application Locally

Start the application locally and exercise its primary workflows:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Verify that the application starts without runtime exceptions and that core functionality behaves as expected.

### 8. Review Runtime Warnings

Monitor the application's console output and logs during local execution for any runtime warnings related to obsolete APIs, missing configuration values, or unhandled exceptions that would not surface at compile time.

### 9. Publish a Self-Contained Build

Produce a self-contained publish output to confirm the application can be packaged for deployment:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj \
  --configuration Release \
  --self-contained true \
  --runtime linux-x64 \
  --output ./publish
```

Adjust the `--runtime` identifier to match your target deployment platform (`win-x64`, `osx-x64`, etc.). Verify the output directory contains all required files.