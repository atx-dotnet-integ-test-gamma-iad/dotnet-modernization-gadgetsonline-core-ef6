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

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types, deprecated APIs, or target framework compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET support policy](https://dotnet.microsoft.com/en-us/platform/support/policy) to ensure you are targeting an actively supported version.

### 4. Run the Application Locally

Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application manually and verify that core functionality behaves as expected compared to the legacy version.

### 5. Execute Existing Tests

If the solution contains a test project, run all tests to confirm no regressions were introduced:

```bash
dotnet test
```

Review the test results and investigate any failures.

### 6. Verify Static Assets and Configuration

- Confirm that `appsettings.json` (and environment-specific variants such as `appsettings.Development.json`) contain the correct configuration values, including connection strings and any keys previously stored in `Web.config`.
- Verify that static files, bundling, and any middleware previously handled by `System.Web` have been correctly replaced with ASP.NET Core equivalents.

### 7. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that were available in .NET Framework but behave differently or have been removed in cross-platform .NET. Common areas to check include:

- `HttpContext` and `HttpRequest` usage
- Session and authentication middleware configuration
- Entity Framework version and provider compatibility
- Any Windows-specific APIs (e.g., registry access, `System.Drawing` without a compatibility package)

### 8. Test on Target Platform

If the intent is to run on a non-Windows operating system, deploy and run the application on that platform explicitly to surface any remaining platform-specific issues that may not appear on Windows.