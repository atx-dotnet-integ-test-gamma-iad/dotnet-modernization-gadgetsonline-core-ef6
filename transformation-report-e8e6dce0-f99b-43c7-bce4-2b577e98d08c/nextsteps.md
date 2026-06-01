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

If the project is a web application, confirm it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and exercise the primary user-facing features to confirm basic functionality.

### 5. Review Removed or Changed APIs

Cross-platform .NET removes or changes several APIs that were available in .NET Framework. Manually review the following areas:

- **`System.Web` dependencies**: Any remaining usage of `HttpContext`, `HttpRequest`, or `HttpResponse` from `System.Web` should now be using the `Microsoft.AspNetCore.Http` equivalents.
- **`ConfigurationManager`**: If the project previously used `System.Configuration.ConfigurationManager`, confirm it has been replaced with `Microsoft.Extensions.Configuration`.
- **`Global.asax`**: Confirm that application startup logic previously in `Global.asax` has been moved to `Program.cs` and/or `Startup.cs`.
- **Entity Framework**: If the project uses Entity Framework, confirm it has been migrated to Entity Framework Core and that all migrations are valid.

### 6. Check Static Files and wwwroot

If this is a web project, confirm that static assets (CSS, JavaScript, images) have been moved to the `wwwroot` folder, as this is required by ASP.NET Core.

### 7. Review Connection Strings and Configuration

Confirm that connection strings and application settings previously stored in `Web.config` have been moved to `appsettings.json`:

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "your-connection-string-here"
  }
}
```

Verify that environment-specific settings are handled using `appsettings.Development.json` and `appsettings.Production.json` as appropriate.

### 8. Run Unit Tests

If the solution contains test projects, run them to confirm no regressions were introduced:

```bash
dotnet test
```

Review any failing tests and address them before proceeding to deployment.

### 9. Validate Database Connectivity

If the application uses a database, confirm that the connection string is correct for the target environment and that the application can successfully connect and perform basic read/write operations at runtime.

### 10. Publish the Application

Once the above steps are validated, publish the application to confirm the output is complete and correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to confirm all expected files are present, then deploy the output to your target environment.