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

Review the output for any warnings about deprecated packages or unresolved dependencies. If any packages are flagged, check [NuGet.org](https://www.nuget.org) for their .NET-compatible equivalents.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues.

```bash
dotnet build --configuration Release
```

Ensure the output shows `Build succeeded` with zero errors. Address any warnings that could indicate runtime issues, such as nullable reference warnings or obsolete API usage.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `TargetFramework` is set to a supported, non-end-of-life version of .NET, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET support lifecycle](https://dotnet.microsoft.com/en-us/platform/support/policy/dotnet-core) to confirm the chosen version is still actively supported.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify existing functionality has not regressed.

```bash
dotnet test --configuration Release
```

Review the test results and investigate any failures. Pay particular attention to tests that cover areas likely affected by the migration, such as data access, authentication, or HTTP pipeline behavior.

### 5. Verify Runtime Behavior

Run the application locally and manually exercise the core workflows.

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Specifically check the following areas, which are commonly affected during legacy migrations:

- **Authentication and session management**: Middleware and cookie behavior can differ between ASP.NET and ASP.NET Core.
- **Database connectivity**: Confirm connection strings are correctly configured in `appsettings.json` and that Entity Framework migrations (if applicable) are up to date.
- **Static files**: Ensure static assets (CSS, JavaScript, images) are being served correctly from the `wwwroot` folder.
- **Configuration**: Verify that settings previously stored in `Web.config` have been correctly moved to `appsettings.json` or environment variables.

### 6. Check for Removed or Changed APIs

Review the code for any usage of APIs that behave differently in modern .NET. Key areas to inspect include:

- `System.Web` references, which are not available in .NET Core and beyond.
- `HttpContext` access patterns, which changed significantly in ASP.NET Core.
- Any use of `ConfigurationManager`, which should be replaced with `IConfiguration`.

You can use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) to scan for remaining compatibility issues.

### 7. Deployment

Once validation is complete, publish the application using the following command:

```bash
dotnet publish --configuration Release --output ./publish
```

Confirm the output directory contains all expected files before deploying to the target environment. Ensure the hosting environment (IIS, Kestrel, or other) is configured to support the target .NET version.