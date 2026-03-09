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

Review the output for any warnings related to missing packages or incompatible target frameworks.

### 2. Build the Solution

Perform a full build to confirm there are no compilation errors:

```bash
dotnet build --configuration Release
```

Verify that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported cross-platform .NET version, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is still referencing a Windows-only framework such as `net48`, update it accordingly.

### 4. Run the Application Locally

Start the application to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality to confirm that pages load, data is retrieved correctly, and no runtime exceptions occur.

### 5. Review Removed or Changed APIs

Check the codebase for any usage of APIs that are not supported in cross-platform .NET, such as:

- `System.Web` namespaces (not available outside of ASP.NET on .NET Framework)
- Windows Registry access
- `HttpContext` usage that relied on `System.Web.HttpContext` rather than `Microsoft.AspNetCore.Http.HttpContext`

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) if a deeper audit is needed.

### 6. Verify Database Connectivity

If the project uses Entity Framework or direct database access, confirm that:

- The connection strings in `appsettings.json` (or equivalent) are correct for the target environment.
- Any Entity Framework migrations are up to date by running:

```bash
dotnet ef database update
```

### 7. Run Existing Tests

If a test project exists in the solution, execute the test suite to validate application behavior:

```bash
dotnet test
```

Review any failing tests and address regressions introduced during the migration.

### 8. Check Static Assets and Configuration Files

- Confirm that `wwwroot` contains all required static assets (CSS, JavaScript, images).
- Verify that `appsettings.json` and `appsettings.Production.json` contain all necessary configuration values that were previously stored in `Web.config` or `App.config`.
- Review any `Web.config` transforms that may need to be replicated in the new configuration system.

### 9. Test on Target Operating Systems

Since the goal is cross-platform support, run and validate the application on each intended operating system (e.g., Windows, Linux, macOS) to surface any platform-specific issues that do not appear during local development.