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

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, such as `net8.0` or `net6.0`. Ensure this aligns with the runtime environment you intend to deploy to.

### 4. Run the Application Locally

Start the application locally to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the core functionality to check for any runtime errors that would not have been caught at compile time.

### 5. Run Existing Tests

If the solution contains a test project, execute the test suite to validate that existing behavior has been preserved:

```bash
dotnet test
```

Review the results for any failing tests that may indicate regressions introduced during the transformation.

### 6. Check for Removed or Changed APIs

Review the code for any usage of APIs that were available in the legacy .NET Framework but have changed or been removed in cross-platform .NET. Pay particular attention to:

- `System.Web` dependencies, which are not available in cross-platform .NET
- Windows-specific APIs such as the registry, certain `System.Drawing` features, or WCF server-side components
- Any third-party libraries that may have been targeting .NET Framework and have not been updated

### 7. Verify Static Files and Configuration

If this is a web application, confirm that:

- `wwwroot` contains the expected static assets
- `appsettings.json` has been properly configured to replace any legacy `Web.config` settings
- Connection strings and application settings are correctly defined

### 8. Test on Target Operating System

If one of the goals of the migration was cross-platform support, run and test the application on the target operating system (Linux or macOS) to surface any platform-specific issues that would not appear on Windows.

### 9. Publish the Application

Once validation is complete, publish the application using the following command, adjusting the runtime identifier as needed:

```bash
dotnet publish --configuration Release --runtime linux-x64 --self-contained false
```

Review the publish output directory to confirm all required files are present before deploying to the target environment.