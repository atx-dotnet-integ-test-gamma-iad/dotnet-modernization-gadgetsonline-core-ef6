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

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Check the output for any warnings that, while non-blocking, may indicate deprecated APIs or compatibility concerns worth addressing.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. If it is targeting an older or end-of-life version (e.g., `netcoreapp3.1` or `net5.0`), update it accordingly:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and exercise its primary features to confirm they function as expected.

### 5. Run Existing Tests

If the solution contains test projects, execute them to validate that existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review the test results and address any failing tests before proceeding.

### 6. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that were available in the legacy .NET Framework but behave differently or are absent in cross-platform .NET. Common areas to check include:

- `System.Web` references (not available in cross-platform .NET)
- `HttpContext` and related types (replaced by `Microsoft.AspNetCore.Http`)
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- Windows-specific APIs such as the registry or certain `System.Drawing` features

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.ApiCompat` tooling to identify any remaining compatibility issues.

### 7. Verify Configuration Files

Ensure that any configuration previously held in `Web.config` or `App.config` has been correctly migrated to `appsettings.json` or `appsettings.{Environment}.json`. Confirm that connection strings, application settings, and environment-specific values are all present and correctly formatted.

### 8. Validate Static Assets and Middleware

If this is a web application, confirm that static files, routing, and middleware are configured correctly in `Program.cs` or `Startup.cs`. Verify that the application serves expected pages and endpoints without errors.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, assets, and dependencies are present.

### 10. Deploy

Copy the published output to the target hosting environment and start the application. Confirm that environment-specific configuration (e.g., connection strings, API keys) is correctly applied in the deployment environment before going live.