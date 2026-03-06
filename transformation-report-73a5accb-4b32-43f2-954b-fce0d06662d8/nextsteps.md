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

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Check the output for any warnings that, while non-blocking, may indicate deprecated APIs or compatibility concerns worth addressing.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET (e.g., `net8.0`). If it is targeting an older version such as `net5.0` or `net6.0`, consider updating it to a long-term support (LTS) release.

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Run the Application Locally

Start the application locally and verify that it behaves as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and test the primary workflows to confirm functional parity with the legacy version.

### 5. Run Existing Tests

If the solution contains a test project, execute the test suite to validate correctness:

```bash
dotnet test
```

Review any failing tests and determine whether they reflect genuine regressions or tests that require updating due to the migration.

### 6. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that were available in the legacy .NET Framework but have changed behavior or been removed in cross-platform .NET. The [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the [Platform Compatibility Analyzer](https://learn.microsoft.com/en-us/dotnet/standard/analyzers/platform-compat-analyzer) can assist with this.

Common areas to inspect include:

- `System.Web` dependencies, which are not available in cross-platform .NET
- `HttpContext` and related ASP.NET types if this is a web project
- Windows-specific APIs (registry access, WCF, etc.) if cross-platform support is required
- Configuration system changes from `web.config` / `app.config` to `appsettings.json`

### 7. Verify Static Assets and Configuration Files

If this is a web application, confirm that:

- `appsettings.json` contains the necessary configuration previously held in `web.config`
- Static files, views, and other content files are correctly included and accessible at runtime

### 8. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.