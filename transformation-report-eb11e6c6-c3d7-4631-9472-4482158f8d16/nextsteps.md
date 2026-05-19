# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored:

```bash
dotnet restore
```

Review the output for any warnings about missing or incompatible packages. If any packages are flagged as incompatible with the new target framework, check [NuGet.org](https://www.nuget.org) for updated versions.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to deprecated APIs or nullable reference types, as these can indicate areas that may cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended .NET version (e.g., `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Run the Application Locally

Start the application and verify it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key features to confirm baseline functionality is intact.

### 5. Check for Removed or Changed APIs

Cross-platform .NET removes certain APIs that were available in .NET Framework. Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` tooling to identify any runtime-level incompatibilities that do not surface as build errors.

Pay particular attention to:
- `System.Web` usages (not available in .NET Core/5+)
- Windows-specific APIs (e.g., registry access, WCF server-side)
- Any third-party libraries that may have .NET Framework-only builds

### 6. Execute Unit Tests

If the solution contains test projects, run them to validate business logic:

```bash
dotnet test
```

Review the test results and investigate any failures, as they may point to behavioral differences between .NET Framework and the new target platform.

### 7. Validate Static Assets and Configuration

- Confirm that `appsettings.json` (or equivalent) contains all configuration values that were previously in `Web.config`.
- Verify that connection strings, application settings, and environment-specific values have been correctly migrated.
- Check that static files, views, and other content files are included in the project and accessible at runtime.

### 8. Test on Target Operating Systems

Since the project is now cross-platform, test on each operating system you intend to support (Windows, Linux, macOS) to surface any platform-specific issues:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

### 9. Publish the Application

Once validation is complete, produce a published output:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files are present before deploying to the target environment.