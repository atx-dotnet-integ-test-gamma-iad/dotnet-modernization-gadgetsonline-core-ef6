# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or version conflicts, even if the build itself succeeds.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is still referencing a Windows-only TFM such as `net48` or `net472`, update it accordingly.

### 4. Check for Windows-Specific APIs

Even without build errors, runtime failures can occur if the code relies on Windows-specific APIs (e.g., `System.Drawing`, `Microsoft.Win32`, Windows registry access). Run a compatibility scan using the .NET Upgrade Assistant or the Platform Compatibility Analyzer:

```bash
dotnet tool install -g upgrade-assistant
upgrade-assistant analyze GadgetsOnline/GadgetsOnline.csproj
```

Review the output for any platform-specific warnings.

### 5. Run the Application Locally

Start the application and verify it runs without runtime exceptions:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the core functionality of the application and confirm expected behavior.

### 6. Run Existing Tests

If the solution contains a test project, execute the test suite to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review any failing tests and determine whether they are caused by the migration or were pre-existing issues.

### 7. Verify Static Assets and Configuration Files

For web projects, confirm the following:

- `appsettings.json` is present and contains the correct configuration values previously held in `Web.config` or `App.config`.
- Static files (CSS, JavaScript, images) are located under the `wwwroot` folder if this is an ASP.NET Core project.
- Any connection strings or environment-specific settings have been migrated properly.

### 8. Test on a Non-Windows Platform (If Cross-Platform Is Required)

If the goal of the migration is to support Linux or macOS, run the application on one of those platforms to surface any remaining platform-specific issues:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present.

### 10. Smoke Test the Published Output

Run the published output directly to confirm it behaves identically to the development build:

```bash
dotnet ./publish/GadgetsOnline.dll
```