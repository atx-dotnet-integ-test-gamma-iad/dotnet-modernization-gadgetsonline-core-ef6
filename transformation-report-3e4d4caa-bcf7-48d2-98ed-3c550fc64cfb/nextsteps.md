# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

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

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an actively supported version of .NET, such as `net8.0`. If it is set to an older version like `net6.0` or `net7.0`, consider updating it, as those versions are out of support.

### 4. Run the Application Locally

Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality to verify that behavior matches the original legacy project.

### 5. Run Existing Tests

If the solution contains test projects, execute them with:

```bash
dotnet test
```

Review the results for any failing tests that may indicate behavioral regressions introduced during the transformation.

### 6. Check for Removed or Changed APIs

Cross-platform .NET removes certain APIs that were available in .NET Framework. Review the code for usage of the following commonly affected areas:

- `System.Web` namespaces (these are not available in cross-platform .NET)
- `HttpContext` usage outside of the ASP.NET Core request pipeline
- Windows-specific APIs such as the registry, WMI, or Windows Communication Foundation (WCF) clients
- `BinaryFormatter`, which is disabled by default in modern .NET

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` tooling to identify any remaining incompatible API calls.

### 7. Verify Configuration Migration

If the original project used `Web.config` or `App.config`, confirm that settings have been migrated to `appsettings.json` and that the application reads them correctly using `IConfiguration`.

### 8. Test on Target Platform

If the goal is to run the application on a non-Windows platform (Linux or macOS), deploy and run the application on that platform to surface any remaining platform-specific issues that may not appear during a Windows build.

### 9. Review Static Files and Bundling

If the project is a web application, verify that static files, bundling, and minification are handled correctly under the ASP.NET Core static file middleware, as the legacy `System.Web.Optimization` bundling approach is not available in cross-platform .NET.

### 10. Publish the Application

Once validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the output directory to confirm all required files are present before deploying to the target environment.