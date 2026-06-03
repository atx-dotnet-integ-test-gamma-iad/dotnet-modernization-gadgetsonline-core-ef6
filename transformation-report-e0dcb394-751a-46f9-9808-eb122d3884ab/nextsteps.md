# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution build output contains no errors for the transformed project (`GadgetsOnline/GadgetsOnline.csproj`). This indicates the migration to cross-platform .NET has completed without any compilation issues.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages.

### 2. Build the Project

Perform a full build to confirm the error-free state is consistent:

```bash
dotnet build --configuration Release
```

Confirm that the output reports `0 Error(s)` and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`). Ensure it is not still referencing a Windows-only framework such as `net48`.

### 4. Run Unit Tests

If a test project exists in the solution, execute the tests to verify runtime behavior has not regressed:

```bash
dotnet test --configuration Release
```

Address any failing tests before proceeding.

### 5. Check for Runtime Dependencies

Some legacy projects rely on Windows-specific APIs (e.g., `System.Web`, Windows registry, COM interop) that compile without errors but fail at runtime. Run the application and exercise its primary workflows to surface any `PlatformNotSupportedException` or similar runtime errors.

### 6. Verify Static Assets and Configuration Files

- Confirm that `appsettings.json` (or equivalent) contains all configuration values previously held in `Web.config` or `App.config`.
- Verify that static files, views, and other content files are included in the project output by checking the build output directory.

### 7. Test on Target Platform

If the goal is cross-platform support, run the application on the intended non-Windows platform (e.g., Linux or macOS) to confirm there are no platform-specific runtime issues:

```bash
dotnet run --configuration Release
```

### 8. Review Nullable and Warning Suppressions

Check the `.csproj` file for any `<Nullable>disable</Nullable>` or `<NoWarn>` entries that may have been added during transformation to suppress errors. Evaluate whether these should be resolved properly rather than suppressed.

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is self-contained and correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.