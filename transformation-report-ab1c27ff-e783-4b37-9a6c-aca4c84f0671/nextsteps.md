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

Review the output for any warnings about deprecated packages or packages that could not be resolved.

### 2. Build the Solution

Perform a full build to confirm there are no compilation errors:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to nullable reference types or obsolete APIs, as these may indicate areas of the code that need attention.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, such as `net8.0` or `net9.0`. Avoid targeting end-of-life versions like `net5.0` or `net6.0` unless there is a specific reason.

### 4. Run the Application Locally

Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application manually to verify that core functionality, routing, and data access behave as expected.

### 5. Check for Runtime Errors

Pay close attention to the following areas at runtime, as these are common sources of issues after a cross-platform migration:

- **Database connectivity**: Connection strings may reference Windows-specific paths or authentication methods (e.g., Windows Integrated Security) that are not supported cross-platform. Update these in `appsettings.json` as needed.
- **File path handling**: Ensure any hardcoded file paths use `Path.Combine` rather than backslash-separated strings.
- **Session and authentication**: If the project uses ASP.NET Identity or session state, verify that middleware is registered correctly in `Program.cs` or `Startup.cs`.

### 6. Execute Existing Tests

If the solution contains a test project, run all tests to validate behavior:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to the migration or pre-existing issues.

### 7. Review Removed or Changed APIs

Cross-platform .NET does not include certain APIs that were available in .NET Framework. Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` tooling to identify any calls to APIs that may have been silently replaced or stubbed during transformation.

### 8. Static File and Configuration Verification

Confirm that:

- `wwwroot` contains all expected static assets.
- `appsettings.json` and `appsettings.Development.json` are present and contain the correct configuration values.
- Any configuration previously stored in `Web.config` has been migrated to `appsettings.json`.