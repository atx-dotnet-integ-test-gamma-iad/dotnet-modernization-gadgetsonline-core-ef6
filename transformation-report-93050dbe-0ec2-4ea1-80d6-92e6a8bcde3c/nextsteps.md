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

Review the output for any warnings related to missing packages or incompatible target frameworks.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Ensure the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported cross-platform .NET version, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is still referencing `net48` or any other .NET Framework moniker, update it accordingly.

### 4. Run the Application Locally

Start the application to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality to confirm behavior matches the legacy version.

### 5. Review Removed or Changed APIs

Check for any usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to review include:

- `System.Web` references (not available in .NET Core/.NET 5+)
- `HttpContext` and related ASP.NET types if this is a web project
- Windows-specific APIs such as the registry, WCF, or `System.Drawing` (which requires additional packages on non-Windows platforms)

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.UpgradeAssistant` tool to surface any remaining compatibility issues.

### 6. Execute Tests

If the solution contains test projects, run them to validate functional correctness:

```bash
dotnet test
```

Review test results and address any failures before proceeding.

### 7. Verify Static Assets and Configuration Files

If this is a web application, confirm the following:

- `appsettings.json` is present and contains the correct configuration values previously held in `Web.config` or `App.config`
- Static files (CSS, JavaScript, images) are located under the `wwwroot` folder
- Connection strings and environment-specific settings are properly configured

### 8. Test on Target Platforms

Since the goal is cross-platform compatibility, run the application on each intended operating system (Windows, Linux, macOS) to identify any platform-specific runtime issues that would not surface during a build.

```bash
dotnet publish --configuration Release --runtime linux-x64
dotnet publish --configuration Release --runtime win-x64
dotnet publish --configuration Release --runtime osx-x64
```

Review the published output and confirm the application starts and functions correctly on each platform.