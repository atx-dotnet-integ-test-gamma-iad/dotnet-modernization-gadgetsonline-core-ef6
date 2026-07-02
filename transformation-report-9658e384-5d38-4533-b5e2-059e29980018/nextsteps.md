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

Verify that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure this aligns with your team's intended runtime version.

### 4. Run the Application Locally

Start the application locally to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and confirm that core functionality behaves the same as it did in the legacy version.

### 5. Run Existing Tests

If the solution contains a test project, execute the test suite:

```bash
dotnet test
```

Review the results and address any failing tests. Failing tests after migration may indicate runtime behavioral differences between the legacy .NET Framework and the new cross-platform .NET runtime.

### 6. Check for Windows-Specific APIs

Search the codebase for any APIs that were available in .NET Framework but are not fully supported in cross-platform .NET. Common areas to check include:

- `System.Web` references (these are not available in cross-platform .NET)
- Windows Registry access (`Microsoft.Win32.Registry`)
- Windows Communication Foundation (WCF) server-side components
- `AppDomain` usage beyond what is supported in .NET Core and later

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` tooling to identify remaining compatibility issues.

### 7. Verify Configuration Files

Confirm that any `web.config` or `app.config` settings have been migrated to the appropriate `appsettings.json` format or equivalent configuration mechanism used by the new project. Connection strings, application settings, and environment-specific values should all be accounted for.

### 8. Test on Target Operating Systems

Since the goal is cross-platform support, test the application on each operating system you intend to support (e.g., Windows, Linux, macOS):

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Pay attention to file path handling, casing sensitivity on Linux, and any platform-specific behavior.

### 9. Publish the Application

Once validation is complete, publish the application for your target runtime:

```bash
dotnet publish --configuration Release --runtime linux-x64 --self-contained false
```

Replace `linux-x64` with your intended runtime identifier (e.g., `win-x64`, `osx-x64`). Review the publish output directory to confirm all required files are present.