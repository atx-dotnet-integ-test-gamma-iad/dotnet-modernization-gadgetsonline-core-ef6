# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored:

```bash
dotnet restore
```

Review the output for any warnings about deprecated packages or unresolved dependencies.

### 2. Build the Solution

Perform a full build to confirm the absence of errors and warnings:

```bash
dotnet build --configuration Release
```

Address any warnings that appear, as some may indicate compatibility issues that do not prevent compilation but could cause runtime problems.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the target framework is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

Refer to the [.NET support policy](https://dotnet.microsoft.com/en-us/platform/support/policy) to ensure you are targeting an actively supported version.

### 4. Check for Removed or Changed APIs

Run the .NET Upgrade Assistant compatibility analyzer or use the `Microsoft.DotNet.ApiCompat` tooling to identify any API usage that may have changed between the legacy .NET Framework and the current .NET version:

```bash
dotnet tool install -g dotnet-apicompat
```

Pay particular attention to:
- `System.Web` usages, which are not available in cross-platform .NET
- `HttpContext`, `HttpRequest`, and `HttpResponse` usage patterns
- Any Windows-specific APIs if cross-platform support is required

### 5. Run the Application Locally

Start the application and verify it runs without runtime exceptions:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's primary workflows and confirm expected behavior.

### 6. Execute Unit Tests

If the solution contains test projects, run them to validate existing functionality:

```bash
dotnet test
```

Review test results and investigate any failures, as they may indicate behavioral differences introduced by the migration.

### 7. Review Configuration Files

- Confirm that `appsettings.json` contains all settings previously held in `Web.config` or `App.config`.
- Verify connection strings, application settings, and environment-specific configurations are correctly represented.
- Ensure any configuration transforms are handled appropriately for different environments (e.g., Development, Production).

### 8. Verify Static Files and Web Assets

If this is a web project, confirm that static files (CSS, JavaScript, images) are being served correctly and that the `wwwroot` folder structure is properly set up.

### 9. Deployment

Once the above steps are completed and the application is validated locally:

1. Publish the application using:
   ```bash
   dotnet publish --configuration Release --output ./publish
   ```
2. Verify the contents of the `./publish` directory are complete.
3. Deploy the published output to the target hosting environment, such as IIS, Azure App Service, or a Linux server with the ASP.NET Core runtime installed.
4. On IIS, ensure the Application Pool is set to **No Managed Code** when hosting an ASP.NET Core application via the ASP.NET Core Module.