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

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that appear, particularly those related to deprecated APIs or nullable reference types, as these may indicate areas of the code that need attention.

### 3. Run Unit Tests

If the solution contains any test projects, execute them to verify that existing functionality has not been broken during the transformation:

```bash
dotnet test
```

Review the test results and investigate any failures. If tests were previously written against .NET Framework-specific behavior, they may need to be updated to reflect cross-platform .NET behavior.

### 4. Verify Runtime Behavior

Run the application locally and manually exercise the core functionality of `GadgetsOnline`:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Pay particular attention to the following areas that commonly differ between .NET Framework and cross-platform .NET:

- **File path handling**: Ensure no hardcoded Windows-style paths (`\`) exist. Replace them with `Path.Combine()` or forward slashes where appropriate.
- **Configuration**: Verify that `web.config` or `app.config` settings have been properly migrated to `appsettings.json` and are being read correctly at runtime.
- **Authentication and Session**: If the application uses ASP.NET membership, forms authentication, or session state, confirm these are functioning as expected under the new middleware pipeline.
- **Database connectivity**: If Entity Framework or another ORM is in use, run the application against the target database and confirm that queries execute correctly and migrations (if any) are up to date.
- **Static files and routing**: For web projects, verify that static assets are served correctly and that all routes resolve as expected.

### 5. Check for Removed or Changed APIs

Review the code for any usage of APIs that were removed or significantly changed in cross-platform .NET. The [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the [Platform Compatibility Analyzer](https://learn.microsoft.com/en-us/dotnet/standard/analyzers/platform-compat-analyzer) can assist in identifying these areas.

Common problem areas include:

- `System.Web` dependencies (not available in cross-platform .NET)
- `BinaryFormatter` (disabled by default)
- Windows-only APIs such as the registry or certain `System.Drawing` features

### 6. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If a newer LTS version of .NET is available and preferred, update this value and re-run the restore and build steps.

### 7. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, assets, and dependencies are present before deploying to the target environment.