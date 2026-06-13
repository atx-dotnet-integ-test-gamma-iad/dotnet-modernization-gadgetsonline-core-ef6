# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored correctly.

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues.

```bash
dotnet build --configuration Release
```

Verify that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, such as `net8.0` or `net6.0`.

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the target framework is outdated (e.g., `netcoreapp3.1`), update it to a current Long-Term Support (LTS) version.

### 4. Run the Application Locally

Start the application and confirm it runs without runtime errors.

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key functionality to verify behavior matches the original legacy project.

### 5. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently in cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. Confirm no runtime references remain.
- **Entity Framework**: If the project uses Entity Framework, confirm it has been migrated to Entity Framework Core and that database migrations are functioning correctly.
- **Authentication/Authorization**: ASP.NET membership providers are not available in cross-platform .NET. Confirm any identity or authentication logic has been replaced with ASP.NET Core Identity or an equivalent.
- **Configuration**: Ensure `web.config` settings have been moved to `appsettings.json` and are being read correctly via `IConfiguration`.
- **Session and HttpContext**: Confirm any usage of `HttpContext` or session state is using the ASP.NET Core equivalents.

### 6. Run Unit Tests

If the solution contains test projects, execute them to validate core logic.

```bash
dotnet test
```

Review test results and address any failing tests before proceeding.

### 7. Verify Database Connectivity

If the application uses a database, confirm the connection string in `appsettings.json` is correct and that the application can connect and perform basic operations at runtime.

### 8. Test on Target Platform

If the goal of the migration is cross-platform support, run the application on the intended target operating system (e.g., Linux or macOS) to confirm there are no platform-specific runtime issues such as file path casing or OS-specific API calls.

### 9. Review Static Files and Middleware Pipeline

In ASP.NET Core, static files and middleware must be explicitly configured. Confirm that `Program.cs` or `Startup.cs` includes the necessary middleware registrations, such as:

```csharp
app.UseStaticFiles();
app.UseRouting();
app.UseAuthentication();
app.UseAuthorization();
```

### 10. Publish the Application

Once validation is complete, publish the application to confirm the output is correct.

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and confirm all required files are present before deploying to the target environment.