# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Run the following command from the solution root to ensure all dependencies are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that appear, particularly those related to deprecated APIs or nullable reference types, as these can indicate areas that may cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the target framework is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET support policy](https://dotnet.microsoft.com/en-us/platform/support/policy) to ensure you are targeting an actively supported version.

### 4. Run the Application Locally

Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality to verify that behavior matches the original legacy project.

### 5. Execute Existing Tests

If the solution contains test projects, run them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review any failing tests and determine whether they reflect actual regressions or tests that need to be updated to reflect the new platform.

### 6. Check for Windows-Specific Dependencies

Since this was a legacy project migration, review the code for any remaining Windows-specific APIs or dependencies, such as:

- `System.Web` references (should be replaced with `Microsoft.AspNetCore` equivalents)
- Windows Registry access
- COM interop components
- `HttpContext.Current` usage

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.UpgradeAssistant` tool to scan for any remaining compatibility issues.

### 7. Validate Configuration

Confirm that configuration files have been properly migrated:

- `Web.config` settings should be moved to `appsettings.json` or `appsettings.{Environment}.json`
- Connection strings should be present and correct in the new configuration format
- Any `system.web` or `system.webServer` sections from `Web.config` should have been replaced with the appropriate ASP.NET Core middleware configuration in `Program.cs` or `Startup.cs`

### 8. Test Database Connectivity

If the application uses a database, verify that:

- Connection strings are correctly configured
- Migrations (if using Entity Framework Core) are up to date by running:

```bash
dotnet ef database update
```

- Data access operations function correctly through manual or automated testing

### 9. Review Static Files and Bundling

If the project serves static assets, confirm that:

- Static files are located in the `wwwroot` folder
- Any legacy bundling and minification configurations (e.g., `BundleConfig.cs`) have been replaced with the appropriate ASP.NET Core static file middleware or a modern front-end build tool

### 10. Cross-Platform Smoke Test

If cross-platform support is a goal, run the application on a non-Windows operating system (Linux or macOS) to identify any platform-specific issues that may not surface on Windows.