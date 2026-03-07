# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or version conflicts.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types, deprecated APIs, or target framework compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET support policy](https://dotnet.microsoft.com/en-us/platform/support/policy) to ensure you are targeting an actively supported version.

### 4. Run the Application Locally

Start the application and verify it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows to confirm baseline functionality is intact.

### 5. Run Existing Tests

If the solution contains test projects, execute them to verify that existing behavior has not regressed:

```bash
dotnet test
```

Review the test output for any failures and investigate any that are present.

### 6. Check for Platform-Specific Code

Search the codebase for any APIs or patterns that may have been available in the legacy .NET Framework but behave differently or are unavailable in cross-platform .NET:

- `System.Web` references (not available in .NET Core and later)
- `HttpContext` usage outside of ASP.NET Core's dependency injection
- Windows Registry access (`Microsoft.Win32.Registry`)
- `AppDomain` members that are no longer supported
- Any P/Invoke calls targeting Windows-specific native libraries

### 7. Verify Configuration Migration

If the project previously used `Web.config` or `App.config`, confirm that settings have been migrated to `appsettings.json` or environment variables as appropriate. Check that:

- Connection strings are correctly defined
- Application settings keys are mapped
- Environment-specific configuration is handled via `appsettings.{Environment}.json`

### 8. Validate Static Assets and Views

If this is a web application, manually verify that:

- Static files (CSS, JavaScript, images) are served correctly
- Razor views or pages render without errors
- Any Bundling/Minification previously handled by `System.Web.Optimization` has been replaced with an alternative such as LibMan or a front-end build tool

### 9. Deployment

Once local validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the contents of the `./publish` directory to your target hosting environment and confirm the application starts and operates correctly there.