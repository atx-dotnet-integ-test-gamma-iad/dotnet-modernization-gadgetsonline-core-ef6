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

Review the output for any warnings related to missing packages or version conflicts. Resolve any flagged issues by updating or replacing deprecated packages in the relevant `.csproj` files.

### 2. Build the Solution

Perform a full build to confirm there are no compilation errors:

```bash
dotnet build --configuration Release
```

Ensure the build completes with zero errors and review any warnings that may indicate compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it targets `net8.0` or the appropriate version and that the project SDK is set correctly:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Changed APIs

Review the codebase for any usage of APIs that were available in .NET Framework but have been removed or changed in cross-platform .NET. Common areas to check include:

- `System.Web` references, which are not available in cross-platform .NET
- `HttpContext`, `HttpRequest`, and `HttpResponse` usage, which should now use the ASP.NET Core equivalents
- `ConfigurationManager`, which should be replaced with `Microsoft.Extensions.Configuration`
- `Global.asax` lifecycle events, which should be migrated to `Program.cs` and middleware

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the locally running application and verify that core functionality behaves as expected. Pay attention to:

- Page rendering and routing
- Database connectivity if applicable
- Authentication and session handling
- Static file serving

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that existing behavior has been preserved:

```bash
dotnet test
```

Review the test results and investigate any failures to determine whether they are caused by behavioral differences between .NET Framework and cross-platform .NET.

### 7. Review Configuration Files

Confirm that `appsettings.json` contains all configuration values that were previously held in `Web.config` or `App.config`. Key areas to verify include:

- Connection strings
- Application settings
- Logging configuration

### 8. Validate Static and Wwwroot Assets

If the project is a web application, confirm that static assets such as CSS, JavaScript, and image files have been placed under the `wwwroot` folder, as this is required by ASP.NET Core.

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.