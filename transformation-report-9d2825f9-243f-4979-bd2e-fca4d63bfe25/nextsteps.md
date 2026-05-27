# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or deprecated APIs, as these can indicate latent issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, verify it references `Microsoft.AspNetCore.App` or the appropriate framework reference instead of legacy `System.Web` assemblies.

### 4. Check for Removed or Replaced APIs

Search the codebase for any usage of APIs that were available in .NET Framework but are not present in modern .NET, such as:

- `System.Web.HttpContext`
- `System.Web.Mvc` (replaced by `Microsoft.AspNetCore.Mvc`)
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- `System.Web.Security`

Run the .NET Upgrade Assistant compatibility analyzer if a thorough audit is needed:

```bash
dotnet tool install -g upgrade-assistant
upgrade-assistant analyze GadgetsOnline/GadgetsOnline.csproj
```

### 5. Run Unit Tests

If the solution contains test projects, execute them to verify runtime behavior has not changed:

```bash
dotnet test --configuration Release
```

Review any failing tests to determine whether they indicate functional regressions introduced during migration.

### 6. Run the Application Locally

Start the application locally and exercise its primary workflows:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Verify the following areas manually:

- Application startup and configuration loading
- Database connectivity and Entity Framework migrations (if applicable)
- Authentication and session handling
- Static file serving
- Any third-party integrations

### 7. Review Configuration Files

Ensure that `appsettings.json` (or `appsettings.Release.json`) contains all configuration values that were previously held in `Web.config` or `App.config`. Pay particular attention to:

- Connection strings
- Application settings keys
- Custom configuration sections

### 8. Verify Static Files and wwwroot

If this is a web project, confirm that static assets (CSS, JavaScript, images) have been moved to the `wwwroot` folder, as required by ASP.NET Core's static file middleware.

### 9. Publish the Application

Once local validation is complete, produce a published output to confirm the application packages correctly:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, assemblies, and assets are present before deploying to the target environment.