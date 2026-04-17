# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored correctly.

```bash
dotnet restore
```

Review the output for any warnings about missing packages, deprecated packages, or version conflicts.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment.

```bash
dotnet build --configuration Release
```

Verify that the build output reports zero errors and review any warnings that may indicate compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`.

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older or end-of-life version (e.g., `net5.0`, `net6.0`), consider updating it to a long-term support (LTS) release.

### 4. Run the Application Locally

Start the application and verify it runs without runtime exceptions.

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to confirm baseline functionality.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate that existing behavior has been preserved.

```bash
dotnet test
```

Review the test results for any failures that may have been introduced during the transformation.

### 6. Check for Removed or Changed APIs

Cross-platform .NET removes certain APIs that were available in .NET Framework. Manually review the code for usage of any of the following commonly affected areas:

- `System.Web` namespace (not available in cross-platform .NET)
- `HttpContext` and related types (replaced by `Microsoft.AspNetCore.Http`)
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- Windows-specific APIs such as the registry, WMI, or Windows Communication Foundation (WCF)
- `BinaryFormatter` (disabled by default in modern .NET)

### 7. Review `web.config` or `app.config`

Configuration files from .NET Framework projects are not fully honored in cross-platform .NET. Confirm that settings previously stored in `web.config` or `app.config` have been migrated to `appsettings.json` or the appropriate `IConfiguration` provider.

### 8. Validate Static Assets and Views

If this is a web application, manually verify that static files, Razor views, or other front-end assets are being served correctly by navigating to the relevant pages in a browser.

### 9. Deployment

Once local validation is complete, publish the application using the following command, adjusting the runtime identifier as needed for your target environment.

```bash
dotnet publish --configuration Release --runtime linux-x64 --self-contained false
```

Common runtime identifiers include:
- `linux-x64`
- `win-x64`
- `osx-x64`

Review the contents of the publish output directory to confirm all required files are present before deploying to the target environment.