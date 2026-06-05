# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

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

If it is targeting an older version such as `net5.0` or `net6.0`, consider updating to `net8.0` as those versions are out of support.

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the primary workflows, such as browsing products, adding items to a cart, and any authentication flows, to confirm runtime behavior is correct.

### 5. Run Existing Tests

If the solution contains a test project, execute the test suite:

```bash
dotnet test
```

Review the results for any failing tests that may indicate runtime regressions not caught at compile time.

### 6. Check for Removed or Changed APIs

Even with a clean build, some .NET APIs behave differently or have been removed in cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **`System.Web` dependencies**: These do not exist in cross-platform .NET. Confirm that any usages have been replaced with ASP.NET Core equivalents.
- **`HttpContext` and session handling**: Verify that session and request/response handling works correctly under ASP.NET Core.
- **Database connectivity**: If Entity Framework is used, confirm the correct provider (e.g., `Microsoft.EntityFrameworkCore.SqlServer`) is referenced and that migrations are up to date by running:

```bash
dotnet ef migrations list --project GadgetsOnline/GadgetsOnline.csproj
```

### 7. Review Configuration Files

Ensure that `appsettings.json` contains all necessary configuration values that were previously held in `Web.config` or `App.config`. Connection strings, application settings, and environment-specific values should all be accounted for.

### 8. Static Files and Bundling

If the project serves static assets, confirm that the `wwwroot` folder is structured correctly and that any bundling or minification previously handled by `BundleConfig` has been replaced with an appropriate alternative, such as LibMan or a front-end build tool.

### 9. Deployment

Once local validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to confirm all required files are present, then deploy the output to your target hosting environment, such as IIS, Azure App Service, or a Linux server with the ASP.NET Core runtime installed.

For IIS hosting, ensure the **ASP.NET Core Hosting Bundle** is installed on the server and that the application pool is set to **No Managed Code**.