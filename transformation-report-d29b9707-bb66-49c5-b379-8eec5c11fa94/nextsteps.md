# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution. The `GadgetsOnline/GadgetsOnline.csproj` project compiled without issues.

## Validation

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version, such as:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net5.0` or `net6.0`, consider updating it to `net8.0` as those versions are out of support.

### 4. Run the Application Locally

Start the application using the .NET CLI to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary workflows, such as browsing products, adding items to a cart, and any authentication flows, to confirm runtime behavior is correct.

### 5. Run Existing Tests

If the solution contains test projects, execute them to verify no regressions were introduced during the transformation:

```bash
dotnet test
```

Review any failing tests and determine whether they indicate a runtime issue or simply require updates to account for framework differences.

### 6. Check for Removed or Changed APIs

Cross-platform .NET removes certain APIs that were available in .NET Framework. Use the .NET Upgrade Assistant compatibility analyzer or review the Microsoft documentation for breaking changes relevant to your target framework. Pay particular attention to:

- `System.Web` dependencies, which are not available in cross-platform .NET
- Windows-specific APIs such as the registry or certain `System.Drawing` features
- Any third-party libraries that may have been replaced with newer package versions during transformation — verify their APIs are being used correctly

### 7. Review Configuration Files

Ensure that `appsettings.json` contains all configuration values that were previously held in `web.config` or `app.config`. Connection strings, application settings, and custom configuration sections should all be accounted for.

### 8. Verify Static Files and Middleware

If this is a web application, confirm that static files, routing, and middleware are configured correctly in `Program.cs` or `Startup.cs`. Test all major routes manually to ensure they resolve and return expected responses.

### 9. Deployment

Once local validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Copy the contents of the `./publish` directory to your target hosting environment. Ensure the target server has the appropriate .NET runtime installed. For a web application hosted on IIS, confirm the ASP.NET Core Hosting Bundle is installed and the application pool is set to **No Managed Code**.