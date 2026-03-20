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

Review the output and confirm that the build succeeds with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET support policy](https://dotnet.microsoft.com/en-us/platform/support/policy) to ensure you are targeting an actively supported version.

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and verify that core functionality behaves as expected compared to the original legacy version.

### 5. Execute Existing Tests

If the solution contains test projects, run them to validate that existing behavior has been preserved:

```bash
dotnet test --configuration Release
```

Review the test results for any failures that may indicate regressions introduced during the transformation.

### 6. Review Removed or Changed APIs

Cross-platform .NET removes or modifies certain APIs that were available in .NET Framework. Manually review the codebase for usage of the following common areas of concern:

- `System.Web` dependencies, which are not available on cross-platform .NET
- `HttpContext` and related types, which may have changed namespaces or behavior
- Windows-specific APIs such as the registry, WCF server-side components, or remoting
- `ConfigurationManager`, which requires the `System.Configuration.ConfigurationManager` NuGet package on cross-platform .NET

### 7. Verify Configuration Files

Ensure that `appsettings.json` or equivalent configuration files are present and correctly structured. If the legacy project used `Web.config` or `App.config`, confirm that the relevant settings have been migrated to the appropriate .NET configuration format.

### 8. Check Static Files and Resources

If `GadgetsOnline` is a web project, verify that static files, views, and other resources are included correctly in the project and are being served as expected at runtime.

### 9. Review Middleware and Startup Configuration

If the project uses ASP.NET Core, review the `Program.cs` or `Startup.cs` file to confirm that middleware, services, and routing are configured correctly for the intended behavior of the application.