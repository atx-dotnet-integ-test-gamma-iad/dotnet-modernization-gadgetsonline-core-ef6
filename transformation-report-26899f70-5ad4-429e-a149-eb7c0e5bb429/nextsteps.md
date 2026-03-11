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

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Review the output and confirm that the build succeeds with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm that the `<TargetFramework>` element is set to a currently supported .NET version, such as `net8.0`. If it is targeting an older or end-of-life version, update it accordingly:

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Run Unit Tests

If the solution contains test projects, execute the test suite to verify that existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review the test results and address any failing tests before proceeding.

### 5. Review Removed or Changed APIs

Cross-platform .NET no longer supports certain Windows-specific APIs that were available in .NET Framework. Manually review the codebase for usage of the following common problem areas:

- `System.Web` namespace references (e.g., `HttpContext`, `HttpRequest` outside of ASP.NET Core abstractions)
- Windows Registry access (`Microsoft.Win32.Registry`)
- `AppDomain` members that are not supported in .NET Core and later
- `BinaryFormatter` serialization, which is disabled by default in modern .NET

### 6. Verify Application Configuration

Ensure that configuration files have been migrated correctly:

- `Web.config` or `App.config` settings should be moved to `appsettings.json` if not already done.
- Connection strings, application settings, and environment-specific values should be confirmed present and correct in the new configuration format.

### 7. Run the Application Locally

Start the application locally and perform manual smoke testing of the core workflows:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the primary features of the application and confirm expected behavior.

### 8. Review Static Files and Middleware (If ASP.NET Core)

If this is a web application, confirm that:

- Static file serving is configured correctly via `UseStaticFiles()`.
- Authentication and authorization middleware is in place and functioning.
- Routing behaves as expected compared to the legacy project.

### 9. Address Compiler Warnings

Even with a clean build, compiler warnings may indicate areas of concern. Run the build with detailed output and review all warnings:

```bash
dotnet build --configuration Release --verbosity detailed
```

Prioritize warnings related to nullable reference types, obsolete API usage, and platform compatibility.

### 10. Validate Runtime Behavior on Target Platform

If the application is intended to run on Linux or macOS as part of the cross-platform goal, test it explicitly on those platforms to surface any remaining platform-specific issues such as file path casing sensitivity or OS-specific API calls.