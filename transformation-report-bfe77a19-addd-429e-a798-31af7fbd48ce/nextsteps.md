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

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`). Ensure this aligns with your team's supported runtime version.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review the test results and address any failures before proceeding.

### 5. Verify Runtime Behavior

Run the application locally and manually exercise the core workflows, particularly any areas that relied on Windows-specific APIs in the legacy project, such as:

- File system path handling (`System.IO`)
- Authentication and identity middleware
- Session and cookie management
- Any use of `HttpContext` or legacy `System.Web` APIs that may have been replaced

### 6. Check for Removed or Replaced APIs

Search the codebase for any usage of APIs that are known to be unavailable or changed in cross-platform .NET, including:

- `System.Web` namespaces
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- `HttpContext.Current`
- Windows Registry access

### 7. Review Application Configuration

Confirm that `web.config` or `app.config` settings have been migrated appropriately to `appsettings.json` and that the configuration is being read correctly at runtime using `IConfiguration`.

### 8. Test on Target Platform

If the intent is to run on Linux or macOS, deploy and run the application on the target operating system to surface any remaining platform-specific issues that may not appear during a Windows build.

### 9. Publish the Application

Once validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the output directory to confirm all required files, static assets, and configuration files are present before deploying to the target environment.