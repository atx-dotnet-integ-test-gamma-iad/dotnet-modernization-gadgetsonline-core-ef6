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

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Run the Application Locally

Start the application using the .NET CLI to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the core functionality to check for any runtime errors that would not surface at compile time.

### 5. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently or have been removed in modern .NET. Pay particular attention to:

- `System.Web` dependencies, which are not available outside of Windows and should be replaced with `Microsoft.AspNetCore` equivalents.
- Any usage of `HttpContext`, `HttpRequest`, or `HttpResponse` that may have changed signatures.
- `ConfigurationManager`, which should be replaced with `Microsoft.Extensions.Configuration`.
- Any third-party NuGet packages that were targeting .NET Framework and may have been carried over without cross-platform compatible versions.

### 6. Run Existing Tests

If the solution contains test projects, run them to validate that existing behavior has been preserved:

```bash
dotnet test
```

Review any failing tests to determine whether they indicate regressions introduced during the transformation or tests that require updating to reflect new API usage.

### 7. Verify Static Files and Configuration

For web projects, confirm the following:

- `appsettings.json` contains the necessary configuration that was previously held in `Web.config` or `App.config`.
- Static files such as CSS, JavaScript, and images are located under the `wwwroot` folder and are being served correctly.
- Any connection strings have been correctly migrated to `appsettings.json` or environment variables.

### 8. Test on Target Platforms

Since the goal of the transformation is cross-platform support, run and validate the application on each platform you intend to support, for example Windows, Linux, or macOS, to confirm there are no platform-specific runtime issues.