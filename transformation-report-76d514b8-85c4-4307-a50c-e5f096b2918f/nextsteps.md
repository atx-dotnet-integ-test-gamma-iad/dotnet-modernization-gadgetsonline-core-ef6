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

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify the `<TargetFramework>` element is set to an appropriate and supported version of .NET, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the target framework is outdated (e.g., `net5.0` or `net6.0`), consider updating it to the current Long-Term Support (LTS) release.

### 4. Run the Application Locally

Start the application locally to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and test core functionality, paying particular attention to areas that relied heavily on Windows-specific or legacy .NET Framework APIs.

### 5. Execute the Test Suite

If the solution contains test projects, run all tests to validate that behavior has not regressed:

```bash
dotnet test
```

Review the test results for any failures or skipped tests that may indicate compatibility issues introduced during the migration.

### 6. Check for Removed or Changed APIs

Use the [.NET Upgrade Assistant](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.ApiCompat` tooling to identify any APIs that were available in .NET Framework but have changed behavior or are no longer present in cross-platform .NET.

Pay specific attention to:
- `System.Web` usages, which are not available in cross-platform .NET
- Windows-specific APIs such as the registry, WCF server-side components, or `System.Drawing` (which requires additional packages on non-Windows platforms)
- Any third-party libraries that may not have cross-platform compatible versions

### 7. Test on Target Platforms

If cross-platform support is a goal, run and validate the application on each intended operating system (e.g., Linux, macOS) to surface any platform-specific runtime issues that would not appear during a Windows build.

### 8. Review Configuration Files

Confirm that configuration has been properly migrated from `Web.config` or `App.config` to the appropriate `appsettings.json` format, and that environment-specific configuration is handled correctly using the `IConfiguration` system.

### 9. Publish the Application

Once validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the output directory to confirm all required files are present, then deploy the contents to your target environment.