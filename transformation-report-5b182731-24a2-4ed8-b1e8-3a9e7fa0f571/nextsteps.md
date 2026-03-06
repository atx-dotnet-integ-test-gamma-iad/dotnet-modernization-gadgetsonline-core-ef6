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

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it targets `net8.0` or `net6.0` and not a legacy `netcoreapp` moniker.

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary workflows, such as browsing products, adding items to a cart, and completing a purchase if applicable.

### 5. Run Existing Tests

If the solution contains test projects, execute them to confirm no regressions were introduced:

```bash
dotnet test
```

Review any failing tests and determine whether failures are due to the migration or pre-existing issues.

### 6. Review Removed or Changed APIs

Cross-platform .NET removes or changes certain APIs that were available in .NET Framework. Manually review the following areas:

- **`System.Web` references**: These are not available in cross-platform .NET. Ensure they have been replaced with ASP.NET Core equivalents.
- **`HttpContext` usage**: Confirm that `System.Web.HttpContext.Current` has been replaced with injected `IHttpContextAccessor`.
- **`ConfigurationManager`**: Confirm that `System.Configuration.ConfigurationManager` has been replaced with `Microsoft.Extensions.Configuration`.
- **`Global.asax`**: Confirm that application startup logic has been moved to `Program.cs` and/or `Startup.cs`.
- **`Web.config`**: Confirm that configuration has been migrated to `appsettings.json`.

### 7. Verify Static Files and Views

If this is a web application, confirm that static files (CSS, JavaScript, images) are served correctly and that all Razor views render without errors.

### 8. Check Database Connectivity

If the application uses a database, verify the connection string in `appsettings.json` is correct and that Entity Framework migrations (if applicable) are up to date:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 9. Deployment

Once local validation is complete, publish the application using the following command:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and deploy them to your target hosting environment, such as IIS, Azure App Service, or a Linux server with the ASP.NET Core runtime installed. Ensure the target environment has the matching .NET runtime version installed.