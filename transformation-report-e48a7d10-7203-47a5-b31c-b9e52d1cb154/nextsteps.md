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

Confirm that the output shows `Build succeeded` with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to an appropriate modern .NET version, such as `net8.0`. Ensure it is not still referencing a legacy `net48` or `netcoreapp` moniker unless intentional.

### 4. Run the Application Locally

Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to confirm runtime behavior matches the pre-migration state.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate functional correctness:

```bash
dotnet test
```

Review the test results for any failures that may indicate behavioral regressions introduced during the migration.

### 6. Check for Removed or Replaced APIs

Inspect the codebase for any usage of APIs that were available in the legacy .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` references (these are not available in .NET Core/.NET 5+)
- `HttpContext` and related types if this is a web project
- `ConfigurationManager` — replaced by `Microsoft.Extensions.Configuration`
- Windows-specific APIs such as the registry or certain `System.Drawing` features

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.ApiCompat` tool to surface any remaining compatibility issues.

### 7. Verify Configuration Files

Ensure that `appsettings.json` (or equivalent) is present and correctly replaces any legacy `Web.config` or `App.config` settings. Confirm that connection strings, application settings, and environment-specific values are properly migrated.

### 8. Test on Target Platform

If cross-platform support is a goal, run and test the application on each intended operating system (e.g., Linux, macOS) to surface any platform-specific runtime issues that would not appear during a Windows-only build.

### 9. Review Static Assets and Middleware (If Web Project)

If `GadgetsOnline` is an ASP.NET project, verify that:

- Static files are served correctly via `UseStaticFiles()`
- Routing is configured properly using the new middleware pipeline
- Authentication and authorization middleware is in place if previously used

### 10. Deploy to Target Environment

Once all validation steps pass, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the contents of the `./publish` directory to the target hosting environment and verify the application starts and operates correctly there.