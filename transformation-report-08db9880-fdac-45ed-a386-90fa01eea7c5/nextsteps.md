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

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues.

```bash
dotnet build --configuration Release
```

Confirm the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET support lifecycle](https://dotnet.microsoft.com/en-us/platform/support/policy/dotnet-core) to ensure you are targeting an actively supported version.

### 4. Run the Application Locally

Start the application and verify it runs without runtime errors.

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows to confirm expected behavior.

### 5. Run Existing Tests

If the solution contains test projects, execute them to verify functional correctness.

```bash
dotnet test
```

Review the test results for any failures that may indicate behavioral regressions introduced during the transformation.

### 6. Check for Removed or Changed APIs

Legacy .NET Framework projects often rely on APIs that have been removed or altered in cross-platform .NET. Manually review the following areas if they are used in the project:

- `System.Web` dependencies — these are not available in cross-platform .NET and must be replaced with ASP.NET Core equivalents.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usage — confirm these have been migrated to their ASP.NET Core counterparts.
- `ConfigurationManager` — this should be replaced with `Microsoft.Extensions.Configuration`.
- `EntityFramework` (classic) — if used, confirm migration to `Microsoft.EntityFrameworkCore`.

### 7. Verify Static Files and Configuration

- Confirm that `appsettings.json` contains all configuration values previously held in `Web.config` or `App.config`.
- Verify that static files (CSS, JavaScript, images) are served correctly under the `wwwroot` directory.

### 8. Test on Target Platforms

Since the goal is cross-platform support, run and validate the application on each intended operating system (Windows, Linux, macOS) to surface any platform-specific issues.

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Pay particular attention to file path handling, as Windows-style paths using backslashes can cause issues on Linux and macOS.

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct.

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.