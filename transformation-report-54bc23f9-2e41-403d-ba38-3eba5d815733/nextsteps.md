# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored correctly.

```bash
dotnet restore
```

Review the output for any warnings about missing packages, deprecated packages, or version conflicts that may not surface as build errors but could cause runtime issues.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations.

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Removed or Changed APIs

Cross-platform .NET removes or changes certain APIs that existed in .NET Framework. Even without build errors, review the following areas manually:

- Any usage of `System.Web` namespaces, which are not available in cross-platform .NET.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages, which have changed significantly.
- `ConfigurationManager` usage, which should be replaced with `Microsoft.Extensions.Configuration`.
- Any Windows-specific APIs such as the registry, WMI, or Windows Event Log.
- `BinaryFormatter` usage, which is disabled by default in modern .NET.

### 4. Run the Application Locally

Start the application and verify it runs without runtime exceptions.

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows to confirm basic functionality is intact.

### 5. Check the Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate and supported version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET release schedule](https://dotnet.microsoft.com/en-us/platform/support/policy/dotnet-core) to ensure you are targeting a version that is still within its support window.

### 6. Run Existing Tests

If the solution contains test projects, execute them to verify that existing behavior has not regressed.

```bash
dotnet test
```

Review any failing tests carefully, as they may indicate runtime behavioral differences between .NET Framework and cross-platform .NET even when the build succeeds.

### 7. Verify Static Assets and Configuration Files

- Confirm that `appsettings.json` (or equivalent) contains all configuration values that were previously in `Web.config` or `App.config`.
- Verify that static files, views, and other content files are included correctly in the project output.

### 8. Publish the Application

Once local validation is complete, produce a published output to confirm the deployment artifact is generated correctly.

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to ensure all expected files, assemblies, and assets are present before deploying to your target environment.