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

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Verify that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`). Ensure this aligns with the runtime version installed on your machine.

```bash
dotnet --version
```

### 4. Run Unit Tests

If the solution contains test projects, execute the test suite to verify that existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review test results and address any failing tests before deployment.

### 5. Run the Application Locally

Start the application locally to confirm it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Manually verify core functionality such as navigation, data access, and any e-commerce workflows (e.g., product listing, cart, checkout) that are central to the application.

### 6. Check for Runtime Compatibility Issues

Even with a clean build, certain issues only surface at runtime. Pay attention to the following areas:

- **Database connectivity**: Confirm connection strings in `appsettings.json` or `web.config` are valid and that the database provider package (e.g., `Microsoft.EntityFrameworkCore.SqlServer`) is compatible with the target framework.
- **Authentication/Authorization**: If the project uses ASP.NET Identity or cookie-based auth, verify middleware is configured correctly in `Program.cs` or `Startup.cs`.
- **Static files and routing**: Confirm that static file middleware and route configurations behave as expected under the new framework.
- **Session and caching**: Verify any session or caching mechanisms are supported and configured for cross-platform .NET.

### 7. Review Removed or Changed APIs

Cross-platform .NET does not support certain APIs that were available in .NET Framework. Review the following:

- Any usage of `System.Web` namespaces should have been replaced. Confirm no remnants exist in the codebase.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages should align with the ASP.NET Core equivalents.
- `ConfigurationManager` should be replaced with `IConfiguration` from `Microsoft.Extensions.Configuration`.

You can use the .NET Upgrade Assistant compatibility analyzer or the `Microsoft.DotNet.ApiCompat` tool to surface any remaining incompatible API usages:

```bash
dotnet tool install -g upgrade-assistant
upgrade-assistant analyze GadgetsOnline/GadgetsOnline.csproj
```

### 8. Validate Configuration Files

Ensure that `appsettings.json` contains all necessary configuration values that were previously held in `web.config` or `app.config`. Common entries to verify include:

- Connection strings
- Application settings (e.g., API keys, feature flags)
- Logging configuration

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, static assets, and configuration files are present.

### 10. Deploy to Target Environment

Copy the published output to the target hosting environment. Ensure the target server has the correct .NET runtime installed:

```bash
dotnet --list-runtimes
```

If hosting on IIS, confirm that the ASP.NET Core Hosting Bundle is installed and that the application pool is set to **No Managed Code**.