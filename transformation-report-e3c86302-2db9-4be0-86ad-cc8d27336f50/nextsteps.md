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

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure this aligns with your team's supported runtime version.

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality to confirm expected behavior is preserved from the legacy version.

### 5. Execute Existing Tests

If the solution contains test projects, run them to validate functional correctness:

```bash
dotnet test
```

Review test results for any failures that may indicate behavioral regressions introduced during the migration.

### 6. Check for Windows-Specific API Usage

Even without build errors, certain APIs may compile successfully but fail at runtime on non-Windows platforms. Search the codebase for usage of the following, and verify cross-platform compatibility:

- `Microsoft.Win32` namespace
- `System.Windows.Forms` or `System.Drawing` (non-web variants)
- Registry access
- Windows file path assumptions (e.g., hardcoded backslashes)

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` package if replacements are needed.

### 7. Validate Database Connectivity and Configurations

If the project uses a database, confirm that connection strings in `appsettings.json` (or equivalent configuration files) are correctly updated and accessible in the new environment. Test all data access paths manually or through integration tests.

### 8. Review `web.config` vs `appsettings.json`

Legacy ASP.NET projects rely on `web.config` for configuration. Confirm that all relevant settings have been migrated to `appsettings.json` and that the application reads them correctly using `IConfiguration`.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is as expected:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, static assets, and dependencies are present.

### 10. Perform a Runtime Smoke Test on the Target Environment

Deploy the published output to the target environment (e.g., a staging server) and perform a basic smoke test by exercising the primary routes and features of the application to confirm it operates correctly outside of a local development context.