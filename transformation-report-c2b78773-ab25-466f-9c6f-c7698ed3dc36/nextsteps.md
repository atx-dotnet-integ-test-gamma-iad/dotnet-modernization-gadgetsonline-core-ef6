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

Verify that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure this aligns with your team's intended runtime target.

### 4. Run the Application Locally

Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's core functionality to confirm expected behavior is preserved from the legacy version.

### 5. Execute Existing Tests

If a test project exists within the solution, run the test suite to validate business logic and functionality:

```bash
dotnet test
```

Review any failing tests and determine whether they reflect regressions introduced during migration or pre-existing issues.

### 6. Check for Windows-Specific API Usage

Even without build errors, the codebase may contain APIs that only function correctly on Windows. Search the codebase for usages of the following, and assess whether cross-platform alternatives are needed:

- `Microsoft.Win32` namespace
- `System.Windows.Forms` or `System.Drawing` (non-web contexts)
- Registry access via `RegistryKey`
- Windows-specific file path assumptions (e.g., hardcoded backslashes)

### 7. Review Configuration and Connection Strings

Confirm that `appsettings.json` (or equivalent configuration files) have been properly migrated from any legacy `Web.config` or `App.config` files. Verify that:

- Database connection strings are correct and accessible
- Any environment-specific settings are accounted for

### 8. Test on a Non-Windows Environment (If Cross-Platform is Required)

If the intent is to run on Linux or macOS, deploy or run the application on the target OS to surface any runtime issues that would not appear during a Windows build.

### 9. Deployment

Once validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the contents of the `./publish` directory to your target hosting environment and verify the application starts and runs correctly in that context.