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

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or deprecated APIs, as these can indicate subtle compatibility issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure this aligns with the runtime version available in your target environment.

### 4. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that existed in .NET Framework but have changed behavior or been removed in cross-platform .NET. Common areas to inspect include:

- `System.Web` references (not available in cross-platform .NET)
- `HttpContext` and related ASP.NET types (should now use `Microsoft.AspNetCore.*`)
- Windows-specific APIs such as the registry, WCF server-side, or `System.Drawing` (requires additional packages on non-Windows platforms)

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to verify that runtime behavior matches the original.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate functional correctness:

```bash
dotnet test
```

Review any failing tests to determine whether they reflect genuine regressions or tests that require updates due to framework differences.

### 7. Validate Static Assets and Configuration

- Confirm that `appsettings.json` (or equivalent) contains all configuration values previously held in `Web.config` or `App.config`.
- Verify that connection strings, application settings, and environment-specific values have been correctly migrated.
- Check that static files, views, and other content files are included in the project and accessible at runtime.

### 8. Test on Target Platform

If cross-platform support is a goal, run and validate the application on each intended operating system (e.g., Linux, macOS) to surface any platform-specific runtime issues that would not appear on Windows.