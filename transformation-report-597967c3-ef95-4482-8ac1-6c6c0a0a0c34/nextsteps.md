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

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types, deprecated APIs, or target framework compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. If it is set to an older or end-of-life version (e.g., `netcoreapp3.1` or `net5.0`), update it accordingly:

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality to confirm behavior matches the original legacy project.

### 5. Execute the Test Suite

If the solution contains test projects, run them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and investigate any failures before proceeding.

### 6. Check for Removed or Changed APIs

Review any usage of APIs that were available in the .NET Framework but have changed or been removed in cross-platform .NET. Pay particular attention to:

- `System.Web` dependencies, which are not available in .NET Core or later
- Windows-specific APIs such as the registry, WCF, or `System.Drawing` (which may require additional packages like `System.Drawing.Common`)
- Any third-party libraries that may have platform-specific limitations

### 7. Verify Static Assets and Configuration

Confirm that configuration files such as `appsettings.json` are present and correctly structured. If the original project used `Web.config`, verify that the relevant settings have been migrated to `appsettings.json` or environment variables.

### 8. Test on Target Platform

If the goal is cross-platform support, run the application on the intended target operating system (e.g., Linux or macOS) to surface any remaining platform-specific issues:

```bash
dotnet publish --configuration Release --runtime linux-x64
```

Then execute the published output on the target machine and verify expected behavior.