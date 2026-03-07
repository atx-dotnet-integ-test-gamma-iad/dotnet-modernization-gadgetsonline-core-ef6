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

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to your intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it targets `net8.0` or the appropriate version and that the project SDK is set to `Microsoft.NET.Sdk.Web`.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary workflows to confirm functionality matches the legacy version.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate that existing logic has not regressed:

```bash
dotnet test
```

Review the test results and address any failing tests before proceeding.

### 6. Check for Removed or Changed APIs

Review the code for any usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to inspect include:

- `System.Web` references, which are not available in cross-platform .NET and should be replaced with ASP.NET Core equivalents.
- `ConfigurationManager`, which should be replaced with `Microsoft.Extensions.Configuration`.
- `HttpContext.Current`, which should be replaced with dependency-injected `IHttpContextAccessor`.
- Windows-specific APIs such as the registry or certain `System.Drawing` features.

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` tooling to surface any remaining compatibility issues.

### 7. Validate Configuration Files

Confirm that `appsettings.json` (or `appsettings.Development.json`) contains all configuration values that were previously held in `Web.config` or `App.config`. Verify that connection strings, application settings, and any custom configuration sections have been migrated correctly.

### 8. Test on a Non-Windows Platform (if applicable)

If cross-platform support is a goal, run the application on Linux or macOS to surface any platform-specific issues:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Pay attention to file path separators, case-sensitive file systems, and any platform-specific dependencies.

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, static assets, and dependencies are present before deploying to the target environment.