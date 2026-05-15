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

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Verify that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`). Ensure this aligns with your team's supported runtime version.

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application's core functionality to confirm runtime behavior matches the legacy version.

### 5. Check for Runtime-Only Issues

Some issues do not surface at build time. Pay specific attention to the following areas during manual testing:

- **Data access**: Verify that database connections, queries, and migrations (if using Entity Framework) function correctly under the new runtime.
- **Authentication and authorization**: Confirm that any login, session, or cookie-based mechanisms behave as expected.
- **Static files and routing**: Ensure all routes resolve correctly and static assets are served properly.
- **Configuration**: Confirm that `appsettings.json` (or equivalent) is being read correctly, replacing any legacy `Web.config` or `App.config` values that may have been migrated.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate core logic:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether failures are due to the migration or pre-existing issues.

### 7. Review Removed or Changed APIs

Cross-reference the codebase against the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the [.NET API compatibility documentation](https://learn.microsoft.com/en-us/dotnet/core/compatibility/) to identify any APIs that were available in the legacy .NET Framework but behave differently or are absent in modern .NET.

### 8. Validate on Target Operating Systems

Since the goal is cross-platform support, test the application on each intended operating system (e.g., Windows, Linux, macOS) to surface any platform-specific issues such as file path casing, line endings, or OS-specific API usage.