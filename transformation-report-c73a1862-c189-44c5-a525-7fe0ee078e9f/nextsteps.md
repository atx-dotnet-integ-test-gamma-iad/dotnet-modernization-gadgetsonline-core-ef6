# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that surface, particularly those related to nullable reference types, deprecated APIs, or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Avoid using `net6.0` or `net7.0` as these are out of support.

### 4. Run the Application Locally

Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows to verify that runtime behavior matches what was expected from the legacy version.

### 5. Run Existing Tests

If the solution contains test projects, execute them with:

```bash
dotnet test
```

Review the results for any failing tests that may indicate behavioral regressions introduced during the migration.

### 6. Check for Removed or Changed APIs

Review the code for any usage of APIs that were available in .NET Framework but have changed or been removed in cross-platform .NET. Common areas to check include:

- `System.Web` references, which are not available in cross-platform .NET
- `HttpContext` and related ASP.NET pipeline components if this is a web project
- Windows-specific APIs such as the registry, WCF server-side components, or `System.Drawing` without the appropriate compatibility package

### 7. Verify Static Files and Configuration

If this is a web application, confirm that:

- `wwwroot` contains the expected static assets
- `appsettings.json` has been populated with the appropriate configuration values previously held in `Web.config` or `App.config`
- Connection strings and application settings have been correctly migrated

### 8. Test on Target Platform

If the intent of the migration was to support non-Windows platforms, run the application on the target operating system (Linux or macOS) to surface any remaining platform-specific dependencies.