# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored correctly.

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues.

```bash
dotnet build --configuration Release
```

Confirm the output shows `Build succeeded` with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET release schedule](https://dotnet.microsoft.com/en-us/platform/support/policy/dotnet-core) to ensure you are targeting a version that is still within its support window.

### 4. Run the Application Locally

Start the application and verify it runs without runtime errors.

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows to confirm expected behavior is preserved from the legacy version.

### 5. Execute Existing Tests

If the solution contains test projects, run them to validate functional correctness.

```bash
dotnet test
```

Review the test results for any failures that may indicate behavioral regressions introduced during the migration.

### 6. Check for Removed or Changed APIs

Some APIs available in .NET Framework are not present or have changed in cross-platform .NET. Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` tooling to identify any runtime-level compatibility issues that would not surface as build errors.

```bash
dotnet tool install -g upgrade-assistant
upgrade-assistant analyze GadgetsOnline/GadgetsOnline.csproj
```

### 7. Validate Configuration Files

Confirm that any configuration previously held in `Web.config` or `App.config` has been correctly migrated to `appsettings.json` or `appsettings.{Environment}.json`. Check that connection strings, application settings, and environment-specific values are all present and correctly formatted.

### 8. Test on Target Operating Systems

Since the goal of the migration is cross-platform support, run and verify the application on each operating system you intend to support (Windows, Linux, macOS) to surface any platform-specific runtime issues such as file path handling or OS-level dependencies.

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Run this on each target platform and compare behavior.

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is as expected.

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, static assets, and dependencies are present before deploying to your target environment.