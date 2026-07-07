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

If the project is a web application, ensure the appropriate SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Replaced APIs

Review the codebase for any usage of Windows-specific or legacy .NET Framework APIs that may have been carried over, such as:

- `System.Web` namespaces (not available in cross-platform .NET)
- `HttpContext` usage outside of the ASP.NET Core pipeline
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- `System.Drawing` (has platform-specific limitations; consider `SkiaSharp` or `ImageSharp` as alternatives)

### 5. Run the Application Locally

Start the application to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary workflows to check for runtime errors.

### 6. Review Application Configuration

Ensure that configuration files have been migrated correctly:

- `Web.config` settings should be moved to `appsettings.json` or `appsettings.{Environment}.json`
- Connection strings should be present and valid in the new configuration format
- Any environment-specific settings should be verified

### 7. Execute Existing Tests

If the solution contains test projects, run them to validate that existing functionality is preserved:

```bash
dotnet test
```

Review the test results and investigate any failures that may indicate behavioral differences between the legacy and modernized versions.

### 8. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, static assets, and configuration files are present before deploying to the target environment.