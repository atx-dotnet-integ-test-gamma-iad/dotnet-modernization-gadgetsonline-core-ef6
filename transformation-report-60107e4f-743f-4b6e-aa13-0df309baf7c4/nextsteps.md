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

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the reported local URL and verify that the application loads and behaves as expected.

### 5. Execute Existing Tests

If the solution contains test projects, run them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review the test results and address any failing tests before proceeding.

### 6. Review Removed or Changed APIs

Cross-platform .NET removes certain APIs that were available in .NET Framework. Manually review the following areas if they were used in the original project:

- `System.Web` dependencies (replaced by `Microsoft.AspNetCore.*`)
- `HttpContext` usage patterns
- Windows-specific APIs such as the registry, WCF, or `System.Drawing` (GDI+)
- Entity Framework 6 vs. Entity Framework Core differences if a database is involved

### 7. Verify Static Files and Configuration

- Confirm that `appsettings.json` contains the correct configuration values previously held in `Web.config` or `App.config`.
- Verify that static files, views, and other content files are present and correctly referenced in the new project structure.

### 8. Test on Target Platform

If the goal is cross-platform deployment, run and test the application on the intended target operating system (Linux or macOS) to surface any remaining platform-specific issues:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Address any runtime exceptions that do not appear on Windows.