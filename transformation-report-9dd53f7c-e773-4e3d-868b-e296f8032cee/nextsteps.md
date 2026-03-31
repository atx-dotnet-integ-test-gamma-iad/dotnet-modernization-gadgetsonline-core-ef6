# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or missing packages targeting the new framework.

### 2. Build the Solution

Perform a full build to confirm there are no errors or warnings that may have been missed:

```bash
dotnet build --configuration Release
```

Address any warnings that surface, particularly those related to deprecated APIs or platform compatibility.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, such as:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it targets `net8.0` or the appropriate modern TFM and that the project SDK is set correctly:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Run the Application Locally

Start the application locally and verify it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key functionality to confirm expected behavior.

### 5. Review Removed or Changed APIs

Check for any usage of APIs that were available in the legacy .NET Framework but behave differently in cross-platform .NET, including:

- `System.Web` dependencies (these are not available in cross-platform .NET)
- `HttpContext` and related types (should now come from `Microsoft.AspNetCore.Http`)
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- `Global.asax` (replaced by `Program.cs` and `Startup.cs` or the minimal hosting model)

### 6. Check Static Files and wwwroot

If the project serves static content, confirm that static files (CSS, JS, images) have been moved to the `wwwroot` folder and that the middleware is configured:

```csharp
app.UseStaticFiles();
```

### 7. Verify Database Connectivity

If the project uses Entity Framework or direct database access, run any pending migrations and confirm the connection string is correctly configured in `appsettings.json`:

```bash
dotnet ef database update
```

Verify that `appsettings.json` contains the correct connection string and that it is being read properly at startup.

### 8. Execute Tests

If a test project exists in the solution, run all tests to validate that existing functionality has not regressed:

```bash
dotnet test
```

Review any failing tests and determine whether they reflect genuine regressions or tests that need to be updated to reflect the new hosting model.

### 9. Review Middleware and Startup Configuration

Confirm that all middleware registered in the legacy `Global.asax` or `Startup.cs` has been correctly migrated to the ASP.NET Core request pipeline. Pay particular attention to:

- Authentication and authorization middleware
- Error handling middleware
- Custom HTTP modules or handlers (these must be rewritten as middleware)

### 10. Publish the Application

Once all validation steps pass, publish the application to verify the output is complete:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files, assemblies, and static assets are present before deploying to the target environment.