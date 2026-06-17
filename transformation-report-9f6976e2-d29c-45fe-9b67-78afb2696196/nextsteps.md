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

Review the output for any warnings about deprecated packages or unresolved dependencies.

### 2. Build the Solution

Perform a full build to confirm the absence of errors:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, as some may indicate compatibility issues that did not produce hard errors.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, such as `net8.0`:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the target framework is outdated (e.g., `net6.0`), consider updating it to a currently supported version.

### 4. Check for Removed or Replaced APIs

Cross-platform .NET removes certain APIs that were available in .NET Framework. Run the .NET Upgrade Assistant compatibility analyzer or the Platform Compatibility Analyzer to identify any runtime issues that would not surface as build errors:

```bash
dotnet add package Microsoft.DotNet.UpgradeAssistant.Extensions.Default.Analyzers
```

Pay particular attention to:
- `System.Web` usages, which are not available in cross-platform .NET
- Windows-specific APIs such as the registry, certain `System.Drawing` features, or WCF server-side components
- Any use of `HttpContext` or `HttpServerUtility` that may need to be replaced with ASP.NET Core equivalents

### 5. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows and confirm that core functionality behaves correctly.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate behavior:

```bash
dotnet test
```

Review any failing tests and determine whether they indicate a regression introduced during migration or a pre-existing issue.

### 7. Verify Static Files and Configuration

- Confirm that `appsettings.json` (and environment-specific variants such as `appsettings.Development.json`) are present and contain the correct configuration values previously held in `Web.config` or `App.config`.
- Ensure static files (CSS, JavaScript, images) are located under the `wwwroot` folder if this is an ASP.NET Core web project.
- Verify that connection strings and any secrets have been migrated appropriately and are not hardcoded.

### 8. Test on Target Platforms

Since the goal is cross-platform compatibility, test the application on each intended operating system (e.g., Windows, Linux, macOS) to surface any platform-specific runtime issues:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Run this on each target platform and compare behavior.

### 9. Review Middleware and Startup Configuration

If this is an ASP.NET Core project, review `Program.cs` (and `Startup.cs` if present) to confirm that:
- Middleware is registered in the correct order
- Authentication and authorization configuration has been migrated correctly
- Any custom HTTP modules or HTTP handlers from the legacy project have been converted to middleware

### 10. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.