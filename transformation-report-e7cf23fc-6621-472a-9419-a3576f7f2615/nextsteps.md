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

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure the appropriate SDK is declared at the top of the project file:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Incompatible APIs

Even without build errors, some APIs that existed in .NET Framework may have been removed or behave differently in cross-platform .NET. Review the following areas manually:

- Any usage of `System.Web` namespaces, which are not available in cross-platform .NET.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages should now reference `Microsoft.AspNetCore.Http`.
- Any references to `ConfigurationManager` should be replaced with `Microsoft.Extensions.Configuration`.
- `Global.asax` logic should be migrated to `Program.cs` and `Startup.cs` (or the minimal hosting model in .NET 6+).

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the URL printed in the console output and verify that the application loads and core functionality works as expected.

### 6. Execute Existing Tests

If the solution contains test projects, run them to confirm existing behavior is preserved:

```bash
dotnet test
```

Review the test results and investigate any failures, as they may indicate behavioral differences between .NET Framework and cross-platform .NET.

### 7. Review Static Files and wwwroot

If this is a web application, confirm that static assets such as CSS, JavaScript, and images have been placed under the `wwwroot` folder, as this is required by ASP.NET Core's static file middleware.

### 8. Validate Configuration Files

- Confirm that `web.config` or `app.config` settings have been migrated to `appsettings.json`.
- Verify that connection strings and application settings are being read correctly at runtime using `IConfiguration`.

### 9. Check Database Connectivity

If the application uses a database, verify that:

- The connection string in `appsettings.json` is correct for the target environment.
- Any Entity Framework usage has been updated to Entity Framework Core if applicable.
- Database migrations run successfully:

```bash
dotnet ef database update
```

### 10. Review Publish Output

Perform a publish to verify the output is complete and correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to confirm all required files are present before deploying to the target environment.