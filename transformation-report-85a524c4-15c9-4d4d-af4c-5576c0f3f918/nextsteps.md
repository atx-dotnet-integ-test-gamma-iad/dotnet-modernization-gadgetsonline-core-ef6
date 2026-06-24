# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it targets `net8.0` or `net6.0` and not a legacy `netcoreapp` moniker.

### 4. Run the Application Locally

Start the application using the .NET CLI to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary workflows to confirm runtime behavior is correct.

### 5. Run Existing Tests

If the solution contains a test project, execute the test suite:

```bash
dotnet test
```

Review any failing tests, as they may indicate behavioral differences introduced during the migration even when the build succeeds.

### 6. Review Removed or Changed APIs

Check the codebase for any usage of APIs that were available in .NET Framework but have changed behavior in cross-platform .NET. Common areas to inspect include:

- `System.Web` references or any shims that replaced them
- `HttpContext`, `HttpRequest`, and `HttpResponse` usage patterns
- `ConfigurationManager` replaced by `Microsoft.Extensions.Configuration`
- `App.config` or `Web.config` values migrated to `appsettings.json`
- Windows-specific APIs such as the registry, WCF, or `System.Drawing` (GDI+)

### 7. Verify Static Files and Configuration

If this is a web project, confirm that:

- `appsettings.json` contains all necessary configuration values previously held in `Web.config`
- Static files (CSS, JavaScript, images) are located under `wwwroot` and are being served correctly
- Connection strings are present and pointing to the correct database instances

### 8. Database Connectivity

If the application uses a database, verify the connection string in `appsettings.json` and confirm the application can connect and perform queries correctly at runtime. If Entity Framework is in use, confirm migrations are up to date:

```bash
dotnet ef database update
```

### 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to ensure all required files are present before deploying to the target environment.