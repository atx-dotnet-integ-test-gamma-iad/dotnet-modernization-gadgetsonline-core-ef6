# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

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

Confirm that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure the appropriate SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Replaced APIs

Even without build errors, certain APIs that existed in .NET Framework may behave differently or have been replaced in cross-platform .NET. Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` tooling to identify any runtime-level compatibility concerns.

Pay particular attention to:

- `System.Web` usages, which are not available in cross-platform .NET
- Windows-specific APIs such as the registry, WCF server-side components, or `HttpContext` usage patterns from classic ASP.NET
- Any third-party NuGet packages that may have been targeting .NET Framework exclusively

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality to confirm expected behavior. Check the console output and application logs for any runtime exceptions.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that business logic has not been affected by the migration:

```bash
dotnet test
```

Review the test results and address any failures before proceeding further.

### 7. Verify Static Files and Configuration

If this is a web application, confirm the following:

- `appsettings.json` contains the correct configuration values previously held in `Web.config` or `App.config`
- Static assets such as CSS, JavaScript, and images are located under the `wwwroot` folder
- Connection strings and environment-specific settings are correctly configured

### 8. Review `Web.config` or `App.config` Remnants

If a `Web.config` or `App.config` file still exists in the project, review it to ensure all relevant settings have been migrated to `appsettings.json` or the appropriate .NET configuration system. These files are largely ignored in cross-platform .NET outside of IIS-specific deployment scenarios.