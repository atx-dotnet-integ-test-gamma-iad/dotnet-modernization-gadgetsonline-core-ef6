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

Confirm that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Ensure this aligns with your team's supported .NET version.

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application's primary workflows to confirm expected behavior is preserved from the legacy version.

### 5. Execute Existing Tests

If the solution contains a test project, run all tests to validate functional correctness:

```bash
dotnet test --configuration Release
```

Review test results for any failures that may indicate regressions introduced during the transformation.

### 6. Check for Windows-Specific Dependencies

Inspect the codebase for any APIs or libraries that were previously Windows-only, such as:

- `Microsoft.Web.Infrastructure`
- `System.Web` namespaces
- Windows Registry access
- COM interop

These will not function on non-Windows platforms and will require replacement or abstraction.

### 7. Verify Static Files and wwwroot

If this is a web application, confirm that static assets such as CSS, JavaScript, and images have been placed under the `wwwroot` folder, which is the expected convention in cross-platform ASP.NET Core projects.

### 8. Review Configuration Files

Ensure that `web.config` settings have been migrated to `appsettings.json` or `appsettings.{Environment}.json` where applicable. Connection strings, application settings, and environment-specific values should all be present and correct.

### 9. Test on Target Platform

If the goal is to run on a non-Windows operating system, deploy and run the application on that platform explicitly to surface any remaining platform-specific issues:

```bash
dotnet publish --configuration Release --runtime linux-x64 --self-contained false
```

Adjust the `--runtime` identifier to match your target environment.

### 10. Review Deprecated or Obsolete API Usage

Run a build with warnings treated as informational and review the output for any `[Obsolete]` API usage that may need to be addressed before the application is considered fully modernized:

```bash
dotnet build --configuration Release /p:TreatWarningsAsErrors=false
```

Address any obsolete API calls by replacing them with their recommended modern equivalents as documented in the .NET migration guides.