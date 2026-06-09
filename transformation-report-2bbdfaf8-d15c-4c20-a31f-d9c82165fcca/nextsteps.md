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

Open `GadgetsOnline/GadgetsOnline.csproj` and verify the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure this aligns with your team's intended runtime version.

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality to confirm runtime behavior matches the legacy version.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate functional correctness:

```bash
dotnet test
```

Review test results and investigate any failures that may indicate behavioral regressions introduced during the migration.

### 6. Check for Windows-Specific APIs

Search the codebase for any APIs that may have been available in the legacy .NET Framework but have limited or no support in cross-platform .NET. Common areas to review include:

- `System.Web` references (these do not exist in cross-platform .NET)
- Windows Registry access (`Microsoft.Win32.Registry`)
- `System.Drawing` usage (requires the `System.Drawing.Common` package and may have platform restrictions)
- Any P/Invoke calls targeting Windows-only native libraries

### 7. Verify Configuration and Static Files

Confirm that configuration files such as `appsettings.json` are present and correctly structured. If the project previously used `Web.config`, verify that all relevant settings have been migrated to `appsettings.json` or the appropriate .NET configuration system.

### 8. Validate Database Connectivity

If the application uses a database, confirm that the connection strings in `appsettings.json` are correct and that the application can successfully connect and perform queries at runtime.

### 9. Test on Target Platform

If the goal is cross-platform support, run and validate the application on each intended operating system (e.g., Windows, Linux, macOS) to surface any platform-specific issues that may not appear during local development.