# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

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

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and verify that core functionality behaves as expected.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate that existing behavior has been preserved:

```bash
dotnet test
```

Review the test results for any failures that may have been introduced during the migration.

### 6. Check for Platform-Specific Code

Search the codebase for any APIs that were available in .NET Framework but may behave differently or be unavailable in cross-platform .NET, including:

- `System.Web` references
- Windows Registry access (`Microsoft.Win32.Registry`)
- `HttpContext` usage patterns specific to `System.Web.HttpContext`
- Any P/Invoke calls targeting Windows-only native libraries

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` tooling to identify remaining compatibility concerns.

### 7. Verify Configuration Migration

Confirm that any `Web.config` or `App.config` settings have been correctly migrated to `appsettings.json` or `appsettings.{Environment}.json`, and that the application reads these values correctly at runtime using `IConfiguration`.

### 8. Test on Target Platform

If the goal is to run on a non-Windows operating system, run the application on the target platform (Linux or macOS) to surface any remaining platform-specific issues that may not appear during a Windows build.

## Deployment

### 1. Publish the Application

Use the following command to produce a published output ready for deployment:

```bash
dotnet publish --configuration Release --output ./publish
```

### 2. Verify Published Output

Inspect the `./publish` directory to confirm all required files, static assets, and configuration files are present.

### 3. Deploy to Target Environment

Copy the contents of the `./publish` directory to the target server or hosting environment and start the application using:

```bash
dotnet GadgetsOnline.dll
```

Confirm the application starts without errors and is accessible as expected.