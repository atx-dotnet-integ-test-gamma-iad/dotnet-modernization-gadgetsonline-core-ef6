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

Confirm that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the target framework does not match your intended version, update it accordingly and re-run the build.

### 4. Run the Application Locally

Start the application to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key features to confirm baseline functionality is intact.

### 5. Execute Existing Tests

If the solution contains a test project, run all tests to validate correctness:

```bash
dotnet test
```

Review the test results for any failures that may indicate behavioral regressions introduced during the migration.

### 6. Check for Removed or Changed APIs

Review the code for any usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to inspect include:

- `System.Web` dependencies, which are not available in cross-platform .NET
- `HttpContext` and related ASP.NET types, which may have moved to different namespaces
- Windows-specific APIs such as the registry, WCF server-side components, or `System.Drawing` without the appropriate compatibility package

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` tooling to identify remaining compatibility issues if any are suspected.

### 7. Verify Configuration Files

Confirm that any `web.config` or `app.config` settings have been migrated to the appropriate `appsettings.json` format and that the application reads configuration correctly at runtime using `Microsoft.Extensions.Configuration`.

### 8. Test on Target Platform

If the goal of the migration is to run on a non-Windows platform, run the application on the target operating system (Linux or macOS) to surface any remaining platform-specific issues:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Address any runtime exceptions that appear only on the target platform.

### 9. Publish the Application

Once all validation steps pass, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to your target environment.