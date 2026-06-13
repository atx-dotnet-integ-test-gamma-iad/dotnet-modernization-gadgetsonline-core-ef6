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

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Ensure the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`). Verify that no Windows-specific TFMs such as `net48` remain unless intentional.

### 4. Run the Application Locally

Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core features to confirm runtime behavior matches the legacy version.

### 5. Execute the Test Suite

If the solution contains test projects, run all tests to validate functional correctness:

```bash
dotnet test
```

Review the test results for any failures that may indicate behavioral regressions introduced during the migration.

### 6. Check for Removed or Changed APIs

Review the codebase for usage of any APIs that were removed or significantly changed between the legacy .NET Framework and the current .NET version. The [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.UpgradeAssistant` tool can assist with identifying remaining compatibility issues.

### 7. Validate Static Assets and Configuration

- Confirm that `appsettings.json` (or equivalent configuration files) contains all settings previously held in `Web.config` or `App.config`.
- Verify that static files, views, and other content files are present and served correctly at runtime.

### 8. Test on Target Platforms

Since the goal is cross-platform support, run and validate the application on each intended operating system (e.g., Windows, Linux, macOS) to surface any platform-specific runtime issues.

### 9. Review Deployment Output

Publish the application to confirm the output is complete and self-contained if required:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to ensure all required files, assemblies, and assets are present before deploying to the target environment.