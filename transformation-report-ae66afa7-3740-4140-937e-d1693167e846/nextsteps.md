# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Verify that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`). Ensure it is not still referencing a Windows-only TFM such as `net48`.

### 4. Run the Application Locally

Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application manually and verify that core functionality behaves as expected. Pay particular attention to any features that relied on Windows-specific APIs in the legacy project.

### 5. Execute Existing Tests

If a test project exists in the solution, run the test suite:

```bash
dotnet test
```

Review the results and address any failing tests. Failing tests after a migration often indicate runtime behavioral differences rather than compilation issues.

### 6. Check for Windows-Specific Dependencies

Search the codebase for any remaining references to Windows-specific libraries or APIs, such as:

- `System.Web` types that may have been shimmed
- `Microsoft.Web.Infrastructure`
- Registry access (`Microsoft.Win32.Registry`)
- Windows-only file path assumptions

Use the .NET Upgrade Assistant compatibility analyzer or the `Microsoft.DotNet.PlatformAbstractions` package to assist in identifying these if needed.

### 7. Review Configuration Files

Confirm that `appsettings.json` (or equivalent) contains all configuration values that were previously in `Web.config` or `App.config`. The transformation tool may not migrate all configuration entries automatically.

### 8. Validate Database Connectivity

If the application uses a database, verify that connection strings are correctly set in the new configuration system and that the application can successfully connect and perform queries at runtime.

### 9. Publish the Application

Once local validation is complete, produce a published output:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required assets, static files, and dependencies are present before deploying to the target environment.