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

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it references `net8.0` or whichever current LTS version is appropriate for your environment.

### 4. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently between .NET Framework and modern .NET. Review the following areas manually:

- **HTTP modules and handlers**: These are not supported in modern .NET. Ensure they have been replaced with ASP.NET Core middleware.
- **`System.Web` dependencies**: Any remaining references to `System.Web` will not function and should be replaced with their ASP.NET Core equivalents.
- **Configuration**: Confirm that `web.config`-based configuration has been migrated to `appsettings.json` and the `IConfiguration` pattern.
- **Global.asax**: Verify this has been replaced with `Program.cs` and `Startup.cs` (or the minimal hosting model).

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the locally running URL and manually verify that core functionality, routing, and pages load as expected.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate that behavior has not regressed:

```bash
dotnet test
```

Review any failing tests and determine whether they indicate a functional regression or a test configuration issue introduced during migration.

### 7. Review Static Files and Content

Confirm that static assets such as CSS, JavaScript, and images are being served correctly. In ASP.NET Core, static files must reside in the `wwwroot` folder and the `UseStaticFiles()` middleware must be registered in the request pipeline.

### 8. Validate Database Connectivity

If the application uses a database, confirm that:

- The connection string in `appsettings.json` is correct for the target environment.
- Entity Framework Core migrations (if applicable) are up to date by running:

```bash
dotnet ef database update
```

### 9. Check Logging and Error Handling

Run the application and intentionally trigger error conditions to confirm that logging and error handling middleware are functioning correctly. Ensure that `appsettings.json` contains appropriate logging configuration.

### 10. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to confirm all required files, assets, and dependencies are present before deploying to the target environment.