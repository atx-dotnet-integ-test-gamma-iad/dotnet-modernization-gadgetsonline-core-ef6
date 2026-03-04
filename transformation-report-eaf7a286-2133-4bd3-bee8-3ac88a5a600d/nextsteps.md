# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without any reported issues.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the absence of errors and review any warnings:

```bash
dotnet build --configuration Release
```

Address any warnings that may indicate deprecated APIs or compatibility concerns, even if they do not prevent compilation.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET support policy](https://dotnet.microsoft.com/en-us/platform/support/policy) to ensure you are targeting an actively supported release.

### 4. Run the Application Locally

Start the application using the .NET CLI to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise its core functionality to confirm runtime behavior matches expectations from the legacy version.

### 5. Execute Existing Tests

If the solution contains test projects, run them to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review test results carefully. Any failing tests should be investigated before proceeding further.

### 6. Check for Removed or Changed APIs

Legacy .NET Framework projects often rely on APIs that have been removed or changed in cross-platform .NET. Review the code for usage of the following common problem areas:

- `System.Web` namespace (not available in .NET Core and later)
- `HttpContext` and related types (replaced by `Microsoft.AspNetCore.Http`)
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- Windows-specific APIs such as the registry or certain `System.Drawing` features

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the [Platform Compatibility Analyzer](https://learn.microsoft.com/en-us/dotnet/standard/analyzers/platform-compat-analyzer) to identify any remaining concerns.

### 7. Review Configuration Files

Confirm that `appsettings.json` (or equivalent) contains all configuration values that were previously held in `Web.config` or `App.config`. Connection strings, application settings, and environment-specific values should all be accounted for.

### 8. Verify Static Files and Web Assets

If this is a web project, confirm that static files such as CSS, JavaScript, and images are located in the `wwwroot` folder and are being served correctly when the application runs.

### 9. Test on Target Operating Systems

Since the goal of the transformation is cross-platform support, run and test the application on each operating system you intend to support (Windows, Linux, macOS) to surface any platform-specific runtime issues.

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Pay particular attention to file path handling, as path separators differ between Windows and Unix-based systems.

### 10. Review Publish Output

Perform a publish to confirm the output is complete and correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to ensure all required files, including configuration files and static assets, are present.